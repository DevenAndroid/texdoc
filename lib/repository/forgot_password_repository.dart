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

Future<ModelForgotPassword> forgetPassword(context, phone) async {
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
log("loginApiUrl Map values${jsonDecode(response.body)}");
  if (response.statusCode == 200) {
    Get.back();
    log("loginApiUrl Response${jsonDecode(response.body)}");
    return ModelForgotPassword.fromJson(jsonDecode(response.body));
  } else {
    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message']);
    Get.back();
    throw Exception("loginApiUrl Error${response.body}");

  }
}



class ModelForgotPassword {
  bool? status;
  String? message;
  Data? data;

  ModelForgotPassword({this.status, this.message, this.data});

  ModelForgotPassword.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? userName;
  int? otp;
  String? userEmail;

  Data({this.userId, this.userName, this.otp, this.userEmail});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    otp = json['otp'];
    userEmail = json['user_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['otp'] = this.otp;
    data['user_email'] = this.userEmail;
    return data;
  }
}
