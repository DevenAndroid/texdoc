import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:texdoc/app_utils/api_constant.dart';
import 'package:texdoc/models/api_models/model_doctor-tips-list_response.dart';
import 'package:texdoc/models/api_models/model_login_response.dart';
import 'package:texdoc/models/api_models/model_user_profile_response.dart';
import 'package:texdoc/app_utils/utils.dart';

Future<ModelUserProfileResponse> getUserProfileData() async {
  ModelLoginData? user = await getToken();
  var token = user.token;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  final response =
      await http.get(Uri.parse(ApiUrls.getUserProfileApiUrl), headers: headers);

  log("Doctor Profile APi Response......  ${response.body}");
  if (response.statusCode == 200) {
    return ModelUserProfileResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}
