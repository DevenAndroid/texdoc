import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:texdoc/app_utils/api_constant.dart';
import 'package:texdoc/models/api_models/model_degree_&_concentration_response.dart';
import 'package:texdoc/models/api_models/model_login_response.dart';
import 'package:texdoc/app_utils/utils.dart';

Future<ModelDegreeAndConcentrationResponse> getMedicalDegreeConversationListData() async {
  var map = <String, dynamic>{};
  // ModelLoginData? user = await getToken();

  // var token = user.token;
  // print("token::::::=>"+token.toString());

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    // HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  final response = await http.get(Uri.parse(ApiUrls.getMedicalDegreeConversationListApiUrl));
      // body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
  log("getMedicalDegreeConversationListApiUrl Map values$map}");
  if (response.statusCode == 200) {
    // hide loader
    // Get.back();
    log("getMedicalDegreeConversationListApiUrl Response${jsonDecode(response.body)}");
    return ModelDegreeAndConcentrationResponse.fromJson(jsonDecode(response.body));

  } else {
    // Get.back();
    throw Exception("getMedicalDegreeConversationListApiUrl Error${response.body}");

  }
}
