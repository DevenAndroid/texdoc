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

Future<ModelCommonResponse> medicalDegreeUpdate(context, medicalDegreeId, concentrationId, institutionName) async {
  var map = <String, dynamic>{};
  ModelLoginData? user = await getToken();
  var token = user.token;

  map['medical_degree_id'] = medicalDegreeId;
  map['concentration_id'] = concentrationId;
  map['institutionname'] = institutionName;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };


  log("medicalDegreeUpdateApiUrl map values::$map");

  final response = await http.post(Uri.parse(ApiUrls.medicalDegreeUpdateApiUrl),
      body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
  log("loginApiUrl Map values$map}");
  if (response.statusCode == 200) {
    // hide loader
     Get.back();
    log("loginApiUrl Response${jsonDecode(response.body)}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));

  } else {
     Get.back();
    throw Exception("loginApiUrl Error${response.body}");

  }
}
