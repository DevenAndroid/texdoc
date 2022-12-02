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

import '../models/api_models/model_common_response.dart';

Future<ModelCommonResponse> sendImage(context,
    base64image,)  async {

  var postUri = Uri.parse("https://tok-2-doc.eoxyslive.com/api/chat-image");
  var request = new http.MultipartRequest("POST", postUri);
  var a = "data:image/jpeg;base64,${base64image}";
  request.fields['image'] = a;
  print(request.fields);
  var response = await request.send();
  // request.headers.addAll(headers);
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());

    return ModelCommonResponse.fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    /*print(await response.stream.bytesToString());
    return ModelCommonResponse(status: false, message: '');*/
    Get.back();
    var bodyData = jsonDecode(response.toString());
    showToast("Someting Wrong");
    throw Exception("updateDoctorRegisterApiUrl Error${response.toString()}");
  }
}
