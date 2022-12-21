import 'package:flutter/material.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/repository/forgot_password_repository.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/widgets/tok2DocTextField.dart';
import 'package:get/get.dart';

import 'verify_your_number_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController mobileController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            leading: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back)),
            title: const Text("Forgot Password"),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                Image.asset(AppAssets.forgotPasswordBg),
                SizedBox(height: 16.h,),
                const Text("Please enter your registered mobile number.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,height: 1.8),),
                SizedBox(height: 40.h,),
                Tok2DocTextField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    hintText: "Enter Mobile Number",
                    obscureText: false.obs,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Mobile number is required'),
                  MinLengthValidator(10, errorText: 'Mobile number must be at least 10 digits long')
                ]),
                ),
                // const Spacer(),
                SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                Tok2DocButton(AppStrings.send, () {
                  if(_formKey.currentState!.validate()){
                    showLoadingIndicatorDialog(context);
                    forgetPassword(context, mobileController.text.trim()).then((value) {
                      if(value.status==true){
                        showToast("Otp has been sent successfully");
                        Get.toNamed(MyRouter.verifyYourNumberScreen,arguments: [
                          mobileController.text.trim(), 'forgot_password',
                          value.data!.userEmail.toString()
                        ]);
                      }else{
                        showToast(value.message);
                      }
                    });
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
