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
  var map = <String, dynamic>{};
  ModelLoginData? user = await getToken();

  var token = user.token;
  print("token::::::=>" + token.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  final response =
      await http.get(Uri.parse(ApiUrls.getUserProfileApiUrl), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
  /* log("getUserProfileApiUrl Map values$map}");
  if (response.statusCode == 200) {
    // hide loader
    // Get.back();
    log("getUserProfileApiUrl Response${jsonDecode(response.body)}");
    return ModelUserProfileResponse.fromJson(jsonDecode(response.body));

  } else {
    // Get.back();
    throw Exception("getUserProfileApiUrl Error${response.body}");

  }
}*/
  log("getUserProfileApiUrl Map values$map}");
  if (response.statusCode == 200) {
    // hide loader
    // Get.back();
    log("getUserProfileApiUrl Response${jsonDecode(response.body)}");
    return ModelUserProfileResponse.fromJson(jsonDecode(response.body));
  } else {
    // Get.back();
    throw Exception("getUserProfileApiUrl Error${response.body}");
  }
}
