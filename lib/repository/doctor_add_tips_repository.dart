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

Future<ModelCommonResponse> addTips(context, title, description, image) async {
  ModelLoginData? user = await getToken();
  var token = user.token;

  var map = <String, dynamic>{};
  map['title'] = title;
  map['description'] = description;
  map['image'] = image;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };

  final response = await http.post(Uri.parse(ApiUrls.addTipsApiUrl),
      body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
  print("loginApiUrl Map values$map}");
  if (response.statusCode == 200) {
    // hide loader
    Get.back();

    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message'].toString());
    print("loginApiUrl Response${jsonDecode(response.body)}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));

  } else {
    Get.back();

    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message'].toString());
    print("loginApiUrl Response${jsonDecode(response.body)}");
    throw Exception("loginApiUrl Error${response.body}");

  }
}
