import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:texdoc/controller/get-user-profile_controller.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:http/http.dart' as http;
import '../app_utils/utils.dart';
import '../models/api_models/model_common_response.dart';
import '../models/api_models/model_get_time.dart';
import '../models/api_models/model_login_response.dart';
import '../repository/get_time_repository.dart';

class DrProfileScreen extends StatefulWidget {
  const DrProfileScreen({Key? key}) : super(key: key);

  @override
  State<DrProfileScreen> createState() => _DrProfileScreenState();
}

class _DrProfileScreenState extends State<DrProfileScreen> {
  /*Future<ModelCommonResponse> setTime() async {
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
      Navigator.pop(context);
      log("loginApiUrl Response${jsonDecode(response.body)}");
      getData();
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      // Get.back();
      var bodyData = jsonDecode(response.body);
      showToast(bodyData['message']);
      Navigator.pop(context);
      throw Exception("loginApiUrl Error${response.body}");
    }
  }*/

  UserProfileController controller = Get.put(UserProfileController());

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
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(() {
        var splist = '';
        var degreesa = '';
        if (controller.isDataLoading.value) {
          // var meDegrees = '';
          for (var specilist in controller.model.value.data!.specialist) {
            if (splist == '') {
              splist = specilist.specialistname.toString();
            } else {
              splist = '$splist, ${specilist.specialistname}';
              print("splist::" + splist);
            }
          }
        }
        if (controller.isDataLoading.value) {
          // var meDegrees = '';
          for (var degrees in controller.model.value.data!.medicalDegree) {
            if (degreesa == '') {
              degreesa = degrees.medicaldegree.toString();
            } else {
              degreesa = '$degreesa, ${degrees.medicaldegree}';
              print("splist::" + degreesa);
            }
          }
        }

        return controller.isDataLoading.value && model.value.data != null
            ? SafeArea(
                child: Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: deviceHeight * 0.42,
                            width: deviceWidth,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(28.0),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                controller
                                    .model.value.data!.profileImage
                                    .toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (_,__,___)=> const Icon(Icons.person,color: Colors.white,),
                              ),
                            ),
                          ),
                          // Positioned(
                          //   top: 4, left: 10,
                          //   child: InkWell(
                          //     onTap: () {
                          //       Get.back();
                          //     },
                          //     child: Icon(Icons.menu),
                          //   ))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.model.value.data!.name.toString(),
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              splist.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff747F94)),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              degreesa.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff747F94)),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            const Text(
                              "Available Now",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff27A363)),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Patient',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.greyColor),
                                      ),

                                      StreamBuilder<dynamic>(
                                          stream: FirebaseFirestore.instance
                                              .collection("firebase_users")
                                              .doc(controller
                                              .model.value.data!.id.toString())
                                              .collection("chat_list")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData){
                                              return Text(
                                                snapshot.data!.docs.length.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                    height: 1.5),
                                              );
                                            }
                                            return const Text("0",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  height: 1.5),
                                            );
                                          }
                                      )
                                    ],
                                  ),
                                  const VerticalDivider(
                                    color: AppTheme.primaryColor,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Experience',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.greyColor),
                                      ),
                                      Text(
                                        "${controller.model.value.data!.experience} Yr",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            height: 1.5),
                                      )
                                    ],
                                  ),
                                  // const VerticalDivider(
                                  //   color: AppTheme.primaryColor,),
                                  // Column(children: const [
                                  //   Text(
                                  //     'Rating', style: TextStyle(fontSize: 14,
                                  //       fontWeight: FontWeight.w400,
                                  //       color: AppTheme.greyColor),),
                                  //   Text(
                                  //     "0.0", style: TextStyle(fontSize: 16,
                                  //       fontWeight: FontWeight.w600,
                                  //       color: Colors.black,
                                  //       height: 1.5),)
                                  // ],),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            const Text(
                              'About',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              controller.model.value.data!.aboutMe.toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.8),
                            ),
                            // SizedBox(height: 48.h,),

                            SizedBox(
                              height: 18.h,
                            ),
                            const Text(
                              'My Availability',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),

                            ...List.generate(model.value.data!.length,
                                (index) => Container(
                                      margin: const EdgeInsets.only(bottom: 1),
                                      child: Container(
                                        //  height: 100,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(child: model.value.data![index].isAvailable == true?
                                            Text(model.value.data![index].day!.replaceFirst(model.value.data![index].day![0],model.value.data![index].day![0].toUpperCase()) ?? "") :
                                            Container(),),
                                            Expanded(child: model.value.data![index].isAvailable == true? Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12.0,
                                                  vertical: 12.0),
                                              child: model.value
                                                  .data![index].open
                                                  .toString() !=
                                                  ""
                                                  ? Text(model
                                                  .value
                                                  .data![index]
                                                  .open ??
                                                  "--:--")
                                                  : const Text("--:--"),
                                            ) : Container(),),
                                            Expanded(child: model.value.data![index].isAvailable == true? const Text("To") : Container(),),
                                            Expanded(child: model.value.data![index].isAvailable == true? Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12.0,
                                                  vertical: 12.0),
                                              child: model.value.data![index]
                                                  .close
                                                  .toString() !=
                                                  ""
                                                  ? Text(model
                                                  .value
                                                  .data![index]
                                                  .close ??
                                                  "--:--")
                                                  : const Text("--:--"),
                                            ) : Container(),),
                                            // Expanded(child: model.value.data![index].isAvailable == true? const Divider() : Container(),)
                                          ],
                                        ),
                                      ),
                                    )),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
