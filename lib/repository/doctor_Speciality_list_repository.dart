import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:texdoc/app_utils/api_constant.dart';
import 'package:texdoc/models/api_models/model_doctor-tips-list_response.dart';
import 'package:texdoc/models/api_models/model_login_response.dart';
import 'package:texdoc/models/api_models/model_speciality_list_response.dart';
import 'package:texdoc/app_utils/utils.dart';

Future<ModelSpecialityListResponse> getSpecialityListData() async {
  var map = <String, dynamic>{};
  ModelLoginData? user = await getToken();

  var token = user.token;
  print("token::::::=>"+token.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
     HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  final response = await http.get(Uri.parse(ApiUrls.getSpecialityListApiUrl  ),headers: headers);

      // body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
  //log("getSpecialityListApiUrl Map values$map}");
  if (response.statusCode == 200) {

    // hide loader
    // Get.back();
    log("getSpecialityListApiUrl Response${jsonDecode(response.body)}");
    return ModelSpecialityListResponse.fromJson(jsonDecode(response.body));

  } else {
    // Get.back();
    throw Exception("getSpecialityListApiUrl Error${response.body}");

  }
}
