
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/controller/category_list_controller.dart';
import 'package:texdoc/controller/doctor_Speciality_list_controller.dart';
import 'package:texdoc/controller/medical_degree_conversation_list_controller.dart';
import 'package:texdoc/models/local_model/firebase_user_model.dart';
import 'package:texdoc/repository/doctor-register_repository.dart';
import 'package:texdoc/repository/firebase_methods.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:texdoc/widgets/tok2DocTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // country code and name
  String? countryPostCode;
  String? countryIsoCode;

  RxBool isPassword = true.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<String> genderList = [
    'Male',
    'Female',
  ]; // Option 2
  List<String> specialistList = [
    'MBBS',
    'BDS',
    'BAMS',
    'BUMS',
    'BHMS',
    'BYNS'
  ]; // Option 2
  List<String> categoryList = [
    'Dentist',
    'Cardiology',
    'Gestrologist'
  ]; // Option 2
  String? selectedGender;
  String? selectedSpecialist = "";
  String? selectedCategory = "";
  String? selectedDegree = "";
  final formkey = GlobalKey<FormState>();


  // final SpecialityListController _specialityListController = Get.put(SpecialityListController());
  final CategoryListController _categoryListController = Get.put(CategoryListController());
  final MedicalDegreeConversationListController _medicalDegreeConversationListController = Get.put(MedicalDegreeConversationListController());



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
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 100.h,),
                const Text(AppStrings.signUp, style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w600),),
                SizedBox(height: 4.h,),
                const Text(AppStrings.pleaseRegisterYourAccountHere,
                  style: TextStyle(fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.greyColor),),
                SizedBox(height: 48.h,),
                Tok2DocTextField(
                  hintText: AppStrings.fullName,
                  controller: fullNameController,
                  prefixIcon: Image.asset(AppAssets.userIcon),
                  obscureText: false.obs,
                  inputFormatters: [LengthLimitingTextInputFormatter(70)],
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: 'Full name is required'),
                  ]),
                ),
                SizedBox(height: 16.h,),
                Tok2DocTextField(
                  hintText: AppStrings.enterYourEmail,
                  controller: emailController,
                  obscureText: false.obs,
                  prefixIcon: Image.asset(AppAssets.emailIcon),
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: 'Email is required'),
                    EmailValidator(errorText: "Enter valid email"),
                  ]),
                ),
                SizedBox(height: 16.h,),
                IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.04),
                        // border: Border.all(color: AppTheme.primaryColor,width: 1.0,),
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    padding: const EdgeInsets.only(right: 10),
                    child: CountryPickerDropdown(
                      isExpanded: true,
                      initialValue: 'zm',
                      itemFilter:(c) => ['ZM'].contains(c.isoCode),
                      itemBuilder: _buildDropdownItem,
                      onValuePicked: (Country country) {
                        print(country.name);
                        print(country.phoneCode);
                        countryPostCode = country.phoneCode;
                        countryIsoCode = country.isoCode.toLowerCase();
                        print("object$countryPostCode");
                        print("object1$countryIsoCode");
                      },
                    ),
                  ),
                ),

                SizedBox(height: 16.h,),
                Tok2DocTextField(
                  hintText: AppStrings.enterMobileNumber,
                  controller: mobileNumberController,
                  keyboardType: TextInputType.phone,
                  obscureText: false.obs,
                  prefixIcon: Image.asset(AppAssets.callLoginIcon),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Mobile number is required'),
                    MinLengthValidator(10, errorText: 'Mobile number must be at least 10 digits long')
                  ]),
                ),

                // SizedBox(height: 16.h,),
                /*Tok2DocTextField(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now(),);

                    if (pickedDate != null) {
                      dobController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    }
                  },
                  hintText: AppStrings.dateOfBrith,
                  controller: dobController,
                  obscureText: false.obs,
                  prefixIcon: Image.asset(AppAssets.calendarIcon),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'dob is required'),
                  ],
                  ),
                ),
                SizedBox(height: 16.h,),
                Obx(() {
                  return !_specialityListController.isDataLoading.value
                      ? CircularProgressIndicator()
                      : Container(
                    height: 65,
                    padding: const EdgeInsets.only(left: 12.0),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12.0),
                      // border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        isExpanded: true,
                        hint: const Text('Select Specialist'),
                        // Not necessary for Option 1
                        value: selectedSpecialist == ""
                            ? null
                            : selectedSpecialist,
                        onChanged: (newValue) {
                          setState(() {
                            selectedSpecialist = newValue as String?;
                            print("selectedSpecialist::::$selectedSpecialist");
                          });
                        },
                        items: _specialityListController.model.value.data!.map((
                            value) {
                          return DropdownMenuItem(
                            value: value.id.toString(),
                            child: Text(value.specialistname,
                              style: const TextStyle(
                                  color: Color(0xff9C9CB4)),),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 16.h,),
                Obx(() {
                  return !_categoryListController.isDataLoading.value
                      ? CircularProgressIndicator()
                      : Container(
                    height: 65,
                    padding: const EdgeInsets.only(left: 12.0),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12.0),
                      // border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        isExpanded: true,
                        hint: const Text('Select Category'),
                        // Not necessary for Option 1
                        value: selectedCategory == ""
                            ? null
                            : selectedCategory,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue as String?;
                            print("selectedDegree::::$selectedCategory");
                          });
                        },
                        items: _categoryListController.model.value.data!.map((
                            value) {
                          return DropdownMenuItem(
                            value: value.id.toString(),
                            child: Text(value.name,
                              style: const TextStyle(
                                  color: Color(0xff9C9CB4)),),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 16.h,),
                Obx(() {
                  return !_medicalDegreeConversationListController.isDataLoading.value
                      ? CircularProgressIndicator()
                      : Container(
                    height: 65,
                    padding: const EdgeInsets.only(left: 12.0),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12.0),
                      // border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        isExpanded: true,
                        hint: const Text('Select Degree'),
                        // Not necessary for Option 1
                        value: selectedDegree == ""
                            ? null
                            : selectedDegree,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDegree = newValue as String?;
                            print("selectedDegree::::$selectedDegree");
                          });
                        },
                        items: _medicalDegreeConversationListController.model.value.data!.medicalDegree.map((
                            value) {
                          return DropdownMenuItem(
                            value: value.id.toString(),
                            child: Text(value.medicaldegree,
                              style: const TextStyle(
                                  color: Color(0xff9C9CB4)),),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 16.h,),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Tok2DocTextField(
                        keyboardType: TextInputType.number,
                        hintText: AppStrings.experience,
                        controller: experienceController,
                        prefixIcon: Image.asset(AppAssets.locationIcon),
                        obscureText: false.obs,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'experience is required')
                        ]),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Flexible(
                      child: Container(
                        height: 58,
                        padding: const EdgeInsets.only(left: 12.0),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(12.0),
                          // border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: const Text('Gender'),
                            // Not necessary for Option 1
                            value: selectedGender,
                            onChanged: (newValue) {
                              setState(() {
                                selectedGender = newValue as String?;
                              });
                            },
                            items: genderList.map((location) {
                              return DropdownMenuItem(
                                value: location,
                                child: Text(location),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/


                SizedBox(height: 16.h,),
                Tok2DocTextField(
                  hintText: AppStrings.password,
                  controller: passwordController,
                  obscureText: isPassword,
                  prefixIcon: Image.asset(AppAssets.lockIcon),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Password is required'),
                    MinLengthValidator(8,
                        errorText: 'Password must be 8 minimum character with at least 1 special character.'),
                    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                        errorText:
                        'Password must be 8 minimum character with at least 1 special character.')
                  ]),
                ),
                // TextFields End
                SizedBox(height: 32.h,),
                Tok2DocButton(AppStrings.signUp, () {
                  if (formkey.currentState!.validate()) {
                    // if (selectedGender == null) {
                    //   showToast("please select gender.");
                    // }
                    // else if (selectedSpecialist == "") {
                    //   showToast("please select specialist.");
                    //   showSnackBar("", "please select specialist.");
                    // }
                    // else if (selectedCategory == "") {
                    //   showToast("please select category.");
                    // } else if (selectedDegree == "") {
                    //   showToast("please select degree.");
                    // }
                    // else {
                      showLoadingIndicatorDialog(context);
                      // Api Commented
                      registerUser(
                          context,
                          fullNameController.text.toString(),
                          countryPostCode ?? "+260",
                          mobileNumberController.text.toString(),
                          emailController.text.toString(),
                          passwordController.text.toString()).then((value) {
                        if (value.status == true) {
                          Get.toNamed(MyRouter.loginScreen);
                        }
                      });
                    // }
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
                    ), onPressed: () {}),
                SizedBox(height: 20.h,),
                CupertinoButton(
                    color: AppTheme.primaryColor.withOpacity(0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.apple, color: Colors.black,),
                        SizedBox(width: 12.w,),
                        const Text('Apple', style: TextStyle(fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),)
                      ],
                    ), onPressed: () {}),
                SizedBox(height: 32.h,),*/
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.alreadyHaveAnAccount, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),),
                    SizedBox(width: 4.w,),
                    InkWell(
                      onTap: () {
                        Get.offAllNamed(MyRouter.loginScreen);
                      },
                      child: const Text(AppStrings.logIn, style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryColor),),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),*/
              ],
            ),
          ),
        ),

      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppStrings.alreadyHaveAnAccount, style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black),),
            SizedBox(width: 4.w,),
            InkWell(
              onTap: () {
                Get.offAllNamed(MyRouter.loginScreen);
              },
              child: const Text(AppStrings.logIn, style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primaryColor),),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDropdownItem(Country country) => Row(
        children: <Widget>[
          const SizedBox(
            width: 16.0,
          ),
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(child: Text("+${country.phoneCode}(${country.name})",
            overflow: TextOverflow.ellipsis,)),
          // Text("+${country.phoneCode}"),
        ],
      );

  // createUser({required String name, required String id, required String email}) async {
  //   //reference to document
  //   final docUser = FirebaseFirestore.instance.collection('users').doc(int.parse(id).toString());
  //
  //   // using json
  //   // final json = {
  //   //   'name': name,
  //   //   'id':id,
  //   //   'email': email,
  //   // };
  //
  //   // using fbuser class model
  //   final user = FBUser(id: id, name: name, email: email
  //   );
  //   //dynamic json
  //   final json = user.toJson();
  //
  //   await docUser.set(json);
  //
  // }


}

