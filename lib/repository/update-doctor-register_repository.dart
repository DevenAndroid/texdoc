import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:texdoc/app_utils/api_constant.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/models/api_models/model_common_response.dart';
import 'package:texdoc/models/api_models/model_login_response.dart';
import 'package:texdoc/app_utils/utils.dart';

import '../routers/my_router.dart';

Future<ModelCommonResponse> updateDoctorRegister(
    {
 required context,
 required name,
 required email,
 required phone,
 required dateOfBirth,
 required experience,
 required gender,
 required categreeId,
 required specialistId,
 required profileImage,
 required aboutMe,
 required medical_degree_id,
 required concentration_ids,
 required institution_name,
  required File document1,
  required File document2,
  required File document3,
  required File document4,
}) async {

  showLoadingIndicatorDialog(context);
  ModelLoginData? user = await getToken();
  var token = user.token;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  var postUri = Uri.parse(ApiUrls.updateDoctorRegisterApiUrl);
  var request = http.MultipartRequest("POST", postUri);
  request.headers.addAll(headers);

  request.fields['name'] = name;
  request.fields['email'] = email;
  request.fields['phone'] = phone;
  request.fields['date_of_birth'] = dateOfBirth;
  request.fields['experience'] = experience;
  request.fields['gender'] = gender;
  request.fields['categree_id'] = categreeId;
  request.fields['specialist_id'] = specialistId;

  if(profileImage != "") {
    request.fields['profile_image'] = profileImage;
  }
  request.fields['about_me'] = aboutMe;
  request.fields['medical_degree_id'] = medical_degree_id;
  request.fields['concentration_ids'] = concentration_ids;
  request.fields['institution_name'] = institution_name;

  if (document1.path != "") {
    request.files.add(await multipartFile("document_1", document1));
  }
  if (document2.path != "") {
    request.files.add(await multipartFile("document_2", document2));
  }
  if (document3.path != "") {
    request.files.add(await multipartFile("document_3", document3));
  }
  if (document4.path != "") {
    request.files.add(await multipartFile("document_4", document4));
  }

  log(request.fields.toString());
  for(var item in request.files){
    log(item.filename.toString());
  }

  var response = await request.send();
  Get.back();
  if (response.statusCode == 200) {
    return ModelCommonResponse.fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    showToast("Something Went Wrong...");
    throw Exception(response);
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}
