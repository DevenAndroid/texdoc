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

Future<ModelCommonResponse> forgotVerifyOtp(context, phone, isOtpVerified) async {
  var map = <String, dynamic>{};
  map['phone'] = phone;
  map['is_otp_verified'] = isOtpVerified;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  final response = await http.post(Uri.parse(ApiUrls.forgotOtpVerfiyApiUrl),
      body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
log("loginApiUrl Map values$map}");
  if (response.statusCode == 200) {
    // hide loader
    // Get.back();
    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message']);
    Navigator.pop(context);
    log("loginApiUrl Response${jsonDecode(response.body)}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));

  } else {
    // Get.back();
    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message']);
    Navigator.pop(context);
    throw Exception("loginApiUrl Error${response.body}");

  }
}
