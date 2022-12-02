  // import 'dart:convert';
  // import 'dart:developer';
  // import 'dart:io';
  //
  // import 'package:get/get.dart';
  // import 'package:multi_select_flutter/util/multi_select_item.dart';
  // import 'package:texdoc/models/api_models/model_speciality_list_response.dart';
  // import 'package:texdoc/repository/doctor_Speciality_list_repository.dart';
  // import 'package:http/http.dart' as http;
  // import '../app_utils/api_constant.dart';
  // import '../app_utils/utils.dart';
  // import '../models/api_models/model_login_response.dart';
  //
  // class SpecialityListController extends GetxController{
  //
  //   List<ModelSpecialityListResponse> subjectData = [];
  //   List<MultiSelectItem> dropDownData = [];
  //   RxBool isDataLoading = false.obs;
  //   // List multipleSelected = [];
  //
  //   @override
  //   void onInit() {
  //     super.onInit();
  //     // getData();
  //   }
  //   Future<ModelSpecialityListResponse> getSpecialityListData() async {
  //     var map = <String, dynamic>{};
  //     ModelLoginData? user = await getToken();
  //
  //     var token = user.token;
  //     print("token::::::=>" + token.toString());
  //
  //     final headers = {
  //       HttpHeaders.contentTypeHeader: 'application/json',
  //       HttpHeaders.acceptHeader: 'application/json',
  //       HttpHeaders.authorizationHeader: 'Bearer $token',
  //     };
  //
  //     final response = await http.get(Uri.parse(ApiUrls.getSpecialityListApiUrl),
  //         headers: headers);
  //     var bodyData = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       /* List<ModelSpecialityListResponse> result = [];
  //       for (var item in bodyData['data']) {
  //         //use your factory if you wanna to parse the data the way you want it
  //         _myActivities=result;
  //         _myActivitiesResult = _myActivities.toString();
  //         result.add(ModelSpecialityListResponse.fromJson(item));
  //       }
  // */
  //       var items = json.decode(response.body);
  //       print(items);
  //
  //
  //
  //       log("getSpecialityListApiUrl Response${jsonDecode(response.body)}");
  //       return ModelSpecialityListResponse.fromJson(jsonDecode(response.body));
  //     } else {
  //
  //       // Get.back();
  //       throw Exception("getSpecialityListApiUrl Error${response.body}");
  //     }
  //   }
  // }