import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texdoc/models/api_models/model_login_response.dart';
import '../resources/app_theme.dart';


showSnackBar(String title, message){
  return Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppTheme.primaryColor,
      forwardAnimationCurve: Curves.easeOutBack,
      colorText: Colors.white,
  );
}

showToast(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<ModelLoginData> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelLoginData user = ModelLoginData.fromJson(jsonDecode(pref.getString('user')!));
  return user;
}