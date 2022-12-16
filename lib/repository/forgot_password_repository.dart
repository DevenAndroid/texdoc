import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:texdoc/app_utils/api_constant.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/models/api_models/model_common_response.dart';
import 'package:texdoc/models/api_models/model_login_response.dart';
import 'package:texdoc/app_utils/utils.dart';

Future<ModelCommonResponse> forgetPassword(context, phone) async {
  var map = <String, dynamic>{};
  map['phone'] = phone;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  final response = await http.post(Uri.parse(ApiUrls.forgetPasswordApiUrl),
      body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
log("loginApiUrl Map values$map}");
  if (response.statusCode == 200) {
    // hide loader
    // Get.back();
    var bodyData = jsonDecode(response.body);
    showToast("Otp has been sent successfully");
    // Fluttertoast.showToast(
    //     msg:bodyData['message'],
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.SNACKBAR, // Also possible "TOP" and "CENTER"
    //     backgroundColor: Colors.green,
    //     textColor:  Colors.white);
   // showToast("Your Otp: "+bodyData['data']['otp'].toString());
    Get.back();
    // Navigator.pop(context);
    log("loginApiUrl Response${jsonDecode(response.body)}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));

  } else {
    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message']);
    Get.back();
    // Navigator.pop(context);
    throw Exception("loginApiUrl Error${response.body}");

  }
}
