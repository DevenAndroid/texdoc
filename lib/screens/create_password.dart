import 'package:flutter/material.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/repository/create-new-password_repository.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/widgets/tok2DocTextField.dart';
import 'package:get/get.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  String? mobileNumber ;
  @override
  void initState() {
    super.initState();
    mobileNumber = Get.arguments[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            leading: InkWell(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back)),
            title: const Text("Create New Password"),
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
                Image.asset(AppAssets.createNewPasswordBg),
                SizedBox(height: 16.h,),
                const Text("Now you can change your password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,height: 1.8),),
                SizedBox(height: 40.h,),
                Tok2DocTextField(
                    hintText: "New Password",
                    prefixIcon: Image.asset(AppAssets.lockIcon),
                    controller: newPassController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                      MinLengthValidator(8,
                          errorText: 'Password must be 8 minimum character with\nat least 1 special character.'),
                      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                          errorText:
                          'Password must be 8 minimum character with at\nleast 1 special character.')
                    ]),
                    obscureText: false.obs),
                SizedBox(height: 24.h,),
                Tok2DocTextField(
                    hintText: "Confirm New Password",
                    controller: confirmPassController,
                    prefixIcon: Image.asset(AppAssets.lockIcon),
                    validator: (value){
                      if(value!.trim().isEmpty){
                        return 'Confirm password is required.';
                      } else
                      if(newPassController.text.trim() != value.trim()) {
                        return "Confirm password is not matching with password.";
                      }
                      else {
                        return null;
                      }
                    }, obscureText: false.obs),
                // const Spacer(),
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Tok2DocButton(AppStrings.save, () {

                  if(_formKey.currentState!.validate()){

                    showLoadingIndicatorDialog(context);
                    createNewPassword(context, newPassController.text.trim(), confirmPassController.text.trim(), mobileNumber.toString()).then((value) {
                      if(value.status){
                        Get.offAllNamed(MyRouter.loginScreen);
                      }
                      return null;
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
