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

import '../models/api_models/model_speciality_list_response.dart';

Future<ModelCommonResponse> doctorSpecialityUpdate(context, specialistId) async {


  ModelLoginData? user = await getToken();
  var token = user.token;

  var map = <String, dynamic>{};
  map['specialist_id'] = specialistId;

  /*Rx<ModelSpecialityListResponse> model = ModelSpecialityListResponse().obs;
  RxBool isDataLoading = false.obs;
  for (var item in model.value.data!) {
    if (item.isselected == true) {
      map['specialist_id'] = specialistId;
    }
  }*/

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };


  log("doctorSpecialityUpdateApiUrl map values::$map");

  final response = await http.post(Uri.parse(ApiUrls.doctorSpecialityUpdateApiUrl),
      body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
  log("doctorSpecialityUpdateApiUrl Map values$map}");
  if (response.statusCode == 200) {
    // hide loader
    Get.back();
    log("doctorSpecialityUpdateApiUrl Response${jsonDecode(response.body)}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));

  } else {
    Get.back();
    throw Exception("doctorSpecialityUpdateApiUrl Error${response.body}");

  }
}
