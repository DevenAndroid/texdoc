import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/repository/doctor-login_verify-otp_repository.dart';
import 'package:texdoc/repository/firebase_methods.dart';
import 'package:texdoc/repository/forgot_verify-otp_repository.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/widgets/tok2DocTextField.dart';
import 'package:get/get.dart';

import '../repository/forgot_password_repository.dart';

class VerifyYourNumberScreen extends StatefulWidget {
  const VerifyYourNumberScreen({Key? key}) : super(key: key);

  @override
  State<VerifyYourNumberScreen> createState() => _VerifyYourNumberScreenState();
}

class _VerifyYourNumberScreenState extends State<VerifyYourNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstPinController = TextEditingController();
  TextEditingController secondPinController = TextEditingController();
  TextEditingController thirdPinController = TextEditingController();
  TextEditingController fourthPinController = TextEditingController();

  String? mobileNumber;
  String? email="";
  String? passedScreen;

  SharedPreferencesData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    email = pref.getString("userEmail")!;
    email = pref.getString("userEmail")!;
    setState(() {

    });
    //degreeId = pref.getString("DegreeId")!;

  }


  @override
  void initState() {
    super.initState();
    mobileNumber = Get.arguments[0];
    passedScreen = Get.arguments[1];
    SharedPreferencesData();
    //email = sharedPreferences.get("userEmail").toString();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: Container(
            // padding: EdgeInsets.all(8),
            child: AppBar(
              backgroundColor: const Color(0xff0E7ECD),
              leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back)),
              title: const Text("Verify Your  Number"),
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              // ...
            ),
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(AppAssets.verifyNumberBg),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Please Enter The 4 Digit Code Send To Your gmail id",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, height: 1.8),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.pinkAccent.withOpacity(0.1)),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          onChanged: (firstPinController) {
                            if (firstPinController.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          controller: firstPinController,
                          // style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        )),
                    Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.pinkAccent.withOpacity(0.1)),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          onChanged: (secondPinController) {
                            if (secondPinController.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          // style: Theme.of(context).textTheme.headline6,
                          controller: secondPinController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        )),
                    Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.pinkAccent.withOpacity(0.1)),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          controller: thirdPinController,
                          onChanged: (thirdPinController) {
                            if (thirdPinController.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          // style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        )),
                    Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.pinkAccent.withOpacity(0.1)),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          controller: fourthPinController,
                          onChanged: (fourthPinController) {
                            if (fourthPinController.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          // style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),

                GestureDetector(
                  onTap: ()
                  {
                    if(_formKey.currentState!.validate()){

                      showLoadingIndicatorDialog(context);
                      forgetPassword(context, "$mobileNumber").then((value) {
                        print(value);
                        if(value.status==true){
                          // Get.toNamed(MyRouter.verifyYourNumberScreen,arguments: [mobileController.text.trim(), 'forgot_password']);
                          // Navigator.pop(context);
                        }else{}
                        return null;
                      });
                    }
                  },
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(
                        color: Color(0xffFF7956),
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Tok2DocButton(AppStrings.verify, () {
                  if (firstPinController.text.isEmpty ||
                      secondPinController.text.isEmpty ||
                      thirdPinController.text.isEmpty ||
                      fourthPinController.text.isEmpty) {
                    showSnackBar('invalid Otp', 'enter valid otp');
                  } else {
                    var otp = firstPinController.text.trim() +
                        secondPinController.text.trim() +
                        thirdPinController.text.trim() +
                        fourthPinController.text.trim();

                    print("otp::::" + otp.toString());
                    print(passedScreen.toString());
                    print(mobileNumber.toString());
                    showLoadingIndicatorDialog(context);

                    switch (passedScreen) {
                      case 'forgot_password':
                        forgotVerifyOtp(context, mobileNumber, otp.toString())
                            .then((value) {
                         // showToast(jsonEncode(value).toString());
                          if (value.status == true) {
                            Get.toNamed(MyRouter.createPasswordScreen,
                                arguments: [mobileNumber]);
                          }
                          // return null;
                        });
                        break;
                      case 'signUp':
                        mobileVerifyOtp(context, mobileNumber.toString(), otp)
                            .then((value) async {
                          if (value.status == true) {
                            showSnackBar("loginVerifyOtp", value.message);
                            Get.toNamed(MyRouter.loginScreen);
                            // Get.back();
                          }
                          return null;
                        });
                        break;
                    }

                    /*showSnackBar('Otp Verified', 'Otp Verified Successfully.');
                    firstPinController.clear();
                    secondPinController.clear();
                    thirdPinController.clear();
                    fourthPinController.clear();*/
                    // Get.toNamed(MyRouter.createPasswordScreen);
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
