import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:texdoc/app_utils/api_constant.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/models/api_models/model_common_response.dart';
import 'package:texdoc/app_utils/utils.dart';

Future<ModelCommonResponse> registerUser(
  context,
  name,
  countryCode,
  phone,
  email,
  password,
) async {
  var map = <String, dynamic>{};
  map['name'] = name;
  map['country_code'] = countryCode;
  map['phone'] = phone;
  map['email'] = email;
  map['password'] = password;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  final response = await http.post(Uri.parse(ApiUrls.registerApiUrl),
      body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
log("registerApi Map values$map}");
log("registerApi Response${jsonDecode(response.body)}");
  if (response.statusCode == 200) {
    // hide loader
    // Get.back();
    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message'].toString());
    // showToast("your OTP: ${bodyData['data']}");
    Navigator.pop(context);
    return ModelCommonResponse.fromJson(jsonDecode(response.body));

  } else {
    // Get.back();
    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message'].toString());
    Navigator.pop(context);
    throw Exception("registerApi Error${response.body}");

  }
}
