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
  ModelLoginData? user = await getToken();
  var token = user.token;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  var postUri = Uri.parse(ApiUrls.updateDoctorRegisterApiUrl);
  var request = new http.MultipartRequest("POST", postUri);
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
    request.files.add(await multipartFile("document[]", document1));
  }
  if (document2.path != "") {
    request.files.add(await multipartFile("document[]", document2));
  }
  if (document3.path != "") {
    request.files.add(await multipartFile("document[]", document3));
  }
  if (document4.path != "") {
    request.files.add(await multipartFile("document[]", document4));
  }
  var response = await request.send();
  request.headers.addAll(headers);
  showLoadingIndicatorDialog(context);
  print("AAAAAAAAAAA${request.fields}");
  if (response.statusCode == 200) {
    print("AAAAAAAAAAA${request.fields}");
    print("AAAAAAAAAAA${request.files}");

    return ModelCommonResponse.fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    /*print(await response.stream.bytesToString());
    return ModelCommonResponse(status: false, message: '');*/
    //Get.back();
    var bodyData = jsonDecode(response.toString());
    showToast("Someting Wrong");
    throw Exception("updateDoctorRegisterApiUrl Error${response.toString()}");
  }
  /* request.send().then((response) {
    if (response.statusCode == 200)
      print("Uploaded!");
    print("Uploaded!");

  });


  print("updateDoctorRegisterApiUrl map values::$map");


  final response = await http.post(Uri.parse(ApiUrls.updateDoctorRegisterApiUrl),
      body: jsonEncode(map), headers: headers);
  if (response.statusCode == 200) {
    // hide loader
    Get.back();
    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message'].toString());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Welcome'),           // To display the title it is optional
            content: Text('Thanks for completing your profile, we will get back to you shortly with your profile approval update '),   // Message which will be pop up on the screen
            // Action widget which will provide the user to acknowledge the choice
            actions: [
              TextButton(                     // FlatButton widget is used to make a text to work like a button

                onPressed: () {
                  Navigator.pop(context);
                },             // function used to perform after pressing the button
                child: Text('CANCEL'),
              ),
              TextButton(

                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ACCEPT'),
              ),
            ],
          );
        });
    log("updateDoctorRegisterApiUrl Response${jsonDecode(response.body)}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));

  } else {
    Get.back();
    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message'].toString());
    throw Exception("updateDoctorRegisterApiUrl Error${response.body}");

  }*/
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}
