import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import '../../app_utils/api_constant.dart';
import '../../app_utils/utils.dart';
import '../../models/api_models/model_common_response.dart';
import '../../models/api_models/model_get_time.dart';
import '../../models/api_models/model_login_response.dart';
import '../../repository/get_time_repository.dart';
import '../dr_profile_screen.dart';
import '../dr_profile_screen.dart';
import 'bottom_navbar_custom.dart';

class SetTimeScreen extends StatefulWidget {
  const SetTimeScreen({Key? key}) : super(key: key);

  @override
  State<SetTimeScreen> createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  // String? monOpenTime;
  // String? monCloseTime;
  // List multipleSelected = [];
  // List checkListItems = [
  //   {
  //     "id": 0,
  //     "value": false,
  //     "day": "Mon",
  //     "fromTime": "13.00",
  //     "toTime": "14.00"
  //   },
  //   {
  //     "id": 1,
  //     "value": false,
  //     "day": "Tue",
  //     "fromTime": "15.00",
  //     "toTime": "16.00"
  //   },
  //   {
  //     "id": 2,
  //     "value": false,
  //     "day": "Wed",
  //     "fromTime": "17.00",
  //     "toTime": "18.00"
  //   },
  //   {
  //     "id": 3,
  //     "value": false,
  //     "day": "Thu",
  //     "fromTime": "19.00",
  //     "toTime": "20.00"
  //   },
  //   {
  //     "id": 4,
  //     "value": false,
  //     "day": "Fri",
  //     "fromTime": "13.00",
  //     "toTime": "13.00"
  //   },
  //   {
  //     "id": 5,
  //     "value": false,
  //     "day": "Sat",
  //     "fromTime": "13.00",
  //     "toTime": "13.00"
  //   },
  //   {
  //     "id": 6,
  //     "value": false,
  //     "day": "Sun",
  //     "fromTime": "13.00",
  //     "toTime": "13.00"
  //   },
  // ];

  // Future<ModelCommonResponse>
  Future<ModelCommonResponse> setTime() async {
    Map<dynamic, dynamic> map = {};
    ModelLoginData? user = await getToken();

    var token = user.token;
    for (var item in model.value.data!) {
      if (item.isAvailable == true) {
        map["${item.day}_availability"] = item.isAvailable!;
        map["${item.day}_open"] = item.open!;
        map["${item.day}_close"] = item.close!;
      }
    }
    print(map);
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response = await http.post(
        Uri.parse("https://tok-2-doc.eoxyslive.com/api/set-time"),
        body: jsonEncode(map),
        headers: headers);
    log("loginApiUrl Map values$map}");
    if (response.statusCode == 200) {
      var bodyData = jsonDecode(response.body);
      print(response.body);
      showToast(bodyData['message']);
      log("loginApiUrl Response${jsonDecode(response.body)}");
      getData();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBarCustom(1),
          ));
      //Get.back();

      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Get.back();
      var bodyData = jsonDecode(response.body);
      showToast(bodyData['message']);
      throw Exception("loginApiUrl Error${response.body}");
    }
  }

  Future<void> displayOpenTimeDialog(int index) async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      setState(() {
        model.value.data![index].open = result.format(context);
        print("lakslls${model.value.data![index].open}");
      });
    }
  }

  Future<void> displayCloseTimeDialog(int index) async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      setState(() {
        model.value.data![index].close = result.format(context);
        print("lakslls${model.value.data![index].close}");
      });
    }
  }

  Rx<ModelGetTime> model = ModelGetTime().obs;
  RxBool status = false.obs;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    getTimeRepo().then((value) {
      if (value.status!) {
        model.value = value;
        status.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: const Text("Set Time"),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )),
      body: Obx(() {
        return status.value
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Set Time',
                            style: TextStyle(
                                height: 3.0,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        height: 15.h,
                      ),
                      ...List.generate(
                          model.value.data!.length,
                          (index) => Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: model.value.data![index].isAvailable ==
                                                true
                                            ? AppTheme.primaryColor
                                            : AppTheme.greyColor)),
                                child: CheckboxListTile(
                                  checkColor: Colors.white,
                                  activeColor: AppTheme.primaryColor,
                                  contentPadding: const EdgeInsets.all(0),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(model.value.data![index].day ?? ""),
                                  value: model.value.data![index].isAvailable,
                                  onChanged: (value)
                                  {
                                    model.value.data![index].isAvailable = value;
                                    setState(() {});
                                  },
                                  secondary: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              if (model.value.data![index]
                                                  .isAvailable ==
                                                  true) {
                                                displayOpenTimeDialog(index);
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 12.0),
                                              child: model.value.data![index]
                                                          .open
                                                          .toString() !=
                                                      ""
                                                  ? Text(model.value
                                                          .data![index].open ??
                                                      "--:--")
                                                  : const Text("--:--"),
                                            )),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            if (model.value.data![index]
                                                    .isAvailable ==
                                                true) {
                                              displayCloseTimeDialog(index);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 12.0),
                                            child: model.value.data![index]
                                                        .close
                                                        .toString() !=
                                                    ""
                                                ? Text(model.value.data![index]
                                                        .close ??
                                                    "--:--")
                                                : const Text("--:--"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                      SizedBox(
                        height: 40.h,
                      ),
                      Tok2DocButton(AppStrings.save, () {
                        setTime();

                        // Get.toNamed(MyRouter.drProfileScreen);
                      })
                    ],
                  ),
                ),
              )
            : const Center(
                child: const CircularProgressIndicator(),
              );
      }),
    );
  }
}
