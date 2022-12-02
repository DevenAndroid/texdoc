import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:texdoc/app_utils/api_constant.dart';
import 'package:texdoc/models/api_models/model_doctor-tips-list_response.dart';
import 'package:texdoc/models/api_models/model_login_response.dart';
import 'package:texdoc/app_utils/utils.dart';

Future<ModelDoctorTipsListResponse> getTipsListData() async {
  var map = <String, dynamic>{};
  ModelLoginData? user = await getToken();

  var token = user.token;
  print("token::::::=>"+token.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  final response = await http.post(Uri.parse(ApiUrls.getDoctorTipsListApiUrl),
      body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
  log("getDoctorTipsListApiUrl Map values$map}");
  if (response.statusCode == 200) {
    // hide loader
    // Get.back();
    log("getDoctorTipsListApiUrl Response${jsonDecode(response.body)}");
    return ModelDoctorTipsListResponse.fromJson(jsonDecode(response.body));

  } else {
    // Get.back();
    throw Exception("getDoctorTipsListApiUrl Error${response.body}");

  }
}
