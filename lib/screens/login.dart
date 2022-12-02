import 'dart:convert';
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/repository/doctor-login_repository.dart';
import 'package:texdoc/repository/firebase_methods.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:texdoc/app_utils/utils.dart';

import 'package:texdoc/widgets/tok2DocTextField.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:form_field_validator/form_field_validator.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPassword = true.obs;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    var deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: deviceHeight,
            width: deviceWidth,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Container(height: deviceHeight, width: deviceWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 100.h,),
                      const Text(AppStrings.logIn, style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w600),),
                      SizedBox(height: 4.h,),
                      const Text(AppStrings.pleaseEnterYourAccountHere,
                        style: TextStyle(fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.greyColor),),
                      SizedBox(height: 48.h,),
                      // mobile controller
                      Tok2DocTextField(
                          hintText: AppStrings.enterYourMobileNumber,
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                          prefixIcon: Image.asset(AppAssets.callLoginIcon),
                          obscureText: false.obs,
                         validator: MultiValidator([
                       RequiredValidator(
                       errorText: 'mobile number is required'),

                    ]),
                        ),
                      // email controller commented

                      /*Tok2DocTextField(
                        hintText: AppStrings.enterYourEmail,
                        controller: emailController,
                        obscureText: false.obs,
                        prefixIcon: Image.asset(AppAssets.emailIcon),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'email is required'),
                          EmailValidator(errorText: "Enter valid email"),
                        ]),
                      ),*/
                    // password commented with sizedbox
                      SizedBox(height: 20.h,),
                      Tok2DocTextField(
                        hintText: AppStrings.password,
                        controller: passwordController,
                        obscureText: isPassword,
                        prefixIcon: const Icon(Icons.lock_open_outlined),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'password is required'),
                          MinLengthValidator(8,
                              errorText: 'password must be at least 8 digits long'),
                        ]),
                      ),
                      SizedBox(height: 32.h,),
                     // Forget password
                      InkWell(
                        onTap: (){
                          Get.toNamed(MyRouter.forgotPasswordScreen);
                        },
                        child: const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(AppStrings.forgotPassword, style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primaryColor),)),
                      ),
                      SizedBox(height: 42.h,),
                      Tok2DocButton(
                          AppStrings.logIn,
                              () {
                                  if(_formKey.currentState!.validate()){
                              showLoadingIndicatorDialog(context);
                              login(context, "${mobileController.text.trim()}", passwordController.text.trim()).then((value) async {
                                print("1111111");
                                if(value.status==true){
                                  print("1111222");
                                  showSnackBar("login Status 1111222", value.message);

                                  // saved login user data
                                  // noneed after change signup process
                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                  pref.setString('user', jsonEncode(value.data));
                                  pref.setBool('document_verified', value.data!.user.documentVerified);
                                  pref.setString('userEmail', value.data!.user.email);
                                  pref.setBool('document_verified', value.data!.user.documentVerified);
                                  print("userEmail ${pref.getString('userEmail')}");
                                  print("document_verified to navigate screen ${pref.getBool('document_verified')}");


                                  if(pref.getBool('document_verified')!=true){
                                    Get.offAllNamed(MyRouter.completeProfileScreen);

                                  }else{
                                    Get.offAllNamed(MyRouter.bottomNavBarCustom);
                                  }

                                  /*try {
                                    FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: pref.getString('userEmail').toString(),
                                        password: mobileController.text.trim())
                                        .then((value) {
                                      Get.offAllNamed(MyRouter.bottomNavBarCustom);
                                    }).catchError((e) {
                                      print("firebase login error0:$e");
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                    });
                                  } on FirebaseException catch (e) {

                                    print("firebase login error1:$e");
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                    throw Exception(e);
                                  } catch (e) {

                                    print("firebase login error2:$e");
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                    throw Exception(e);
                                  }*/

                                  // Navigator.pop(context);
                                  // Get.toNamed(MyRouter.verifyYourNumberScreen,arguments: [mobileController.text.trim().toString()]);
                                }else{
                                  showToast( value.message);
                                  //showSnackBar("login Status 1111333", value.message);
                                  // Navigator.pop(context);
                                }
                                return null;
                              });
                            }
                              }),
                      SizedBox(height: 28.h,),
                      /*Row(
                        children: const [
                          Expanded(child: Divider(color: Colors.grey,)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(AppStrings.orContinueWith,
                              style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.greyColor),),
                          ),
                          Expanded(child: Divider(color: Colors.grey,)),
                        ],
                      ),
                      SizedBox(height: 46.h,),
                      CupertinoButton(
                          color: AppTheme.primaryColor.withOpacity(0.08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppAssets.googleIcon, fit: BoxFit.fill,),
                              SizedBox(width: 12.w,),
                              const Text('Google', style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),)
                            ],
                          ), onPressed: (){}),
                      SizedBox(height: 20.h,),
                      CupertinoButton(
                          color: AppTheme.primaryColor.withOpacity(0.08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.apple,color: Colors.black,),
                              SizedBox(width: 12.w,),
                              const Text('Apple', style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),)
                            ],
                          ), onPressed: (){}),*/
                    ],
                  ),
                ),
                Positioned(
                  bottom: 24.0,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppStrings.dontHaveAnAccount, style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),),
                      SizedBox(width: 4.w,),
                      InkWell(
                        onTap: (){
                          print("object");
                          Get.offAllNamed(MyRouter.signUpScreen);
                        },
                        child: const Text(AppStrings.signUp, style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.primaryColor),),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
