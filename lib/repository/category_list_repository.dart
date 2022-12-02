import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:texdoc/app_utils/api_constant.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:texdoc/models/api_models/model_category_list_response.dart';

Future<ModelCatagreeListResponse> catagreeListData(context) async {
  var map = <String, dynamic>{};
  // ModelLogInData? user = await getToken();
  // var token = user.token;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    // HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  final response = await http.get(Uri.parse(ApiUrls.categoryListApiUrl));
  // body: jsonEncode(map), headers: headers);

  // Show loader
  // showLoadingIndicatorDialog(context);
  // log("categoryListApiUrl Map values$map}");
  // log("categoryListApiUrl Response${jsonDecode(response.body)}");
  if (response.statusCode == 200) {
    // hide loader
    // Get.back();
    var bodyData = jsonDecode(response.body);
    // showToast(bodyData['message'].toString());
    // Navigator.pop(context);
    return ModelCatagreeListResponse.fromJson(jsonDecode(response.body));
  } else {
    // Get.back();
    var bodyData = jsonDecode(response.body);
    showToast(bodyData['message'].toString());
    // Navigator.pop(context);
    throw Exception("categoryListApiUrl Error${response.body}");
  }
}
