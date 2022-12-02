import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/controller/category_list_controller.dart';
import 'package:texdoc/controller/get-user-profile_controller.dart';
import 'package:texdoc/repository/update-doctor-register_repository.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:texdoc/widgets/tok2DocTextField.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../resources/new_helper.dart';
import 'Doctor Screens/bottom_navbar_custom.dart';
import 'dr_profile_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  // profileController
  UserProfileController controller = Get.put(UserProfileController());
  final CategoryListController _categoryListController =
      Get.put(CategoryListController());


  final _formKey = GlobalKey<FormState>();

  // TextEditing Controllers



  // String? documentName1 = "";
  // File? documentPath1;
  //
  // String? documentName2 = "";
  // String? documentPath2;
  //
  // String? documentName3 = "";
  // String? documentPath3;
  //
  // String? documentName4 = "";
  // String? documentPath4;

  Rx<File> document1 = File("").obs;
  Rx<File> document2 = File("").obs;
  Rx<File> document3 = File("").obs;
  Rx<File> document4 = File("").obs;

  String? medical_degree_id = "";
  String? concentration_ids = "";
  String? institution_name = "";

  String? categreeId = "";
  String? experience = "";
  String? gender = "";
  String? dateOfBirth = "";
  var degree;
  var spe;

  List<String> categoryList = [
    'MBBS',
    'BDS',
    'BAMS',
    'BHMS',
    'BUMS',
    'BYNS'
  ]; // Option 2


  var concentration;
  var institutionName;
  var degreeId;
  var ConcentrationId;


  getdegreeData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();


    degree = pref.getString("DegreeName")!;
    concentration = pref.getString("ConcentrationName")!;
    institutionName = pref.getString("institutionName")!;
    degreeId = pref.getString("DegreeId")!;
    ConcentrationId = pref.getString("concentrationId")!;
    print("degree---------    ${degree}");
    print("concentration---------    ${concentration}");
    print("institutionName---------    ${institutionName}");
    print("degreeId---------    ${degreeId}");
    print("ConcentrationId---------    ${ConcentrationId}");


  }

  @override
  void initState() {
    super.initState();
    controller.getData();
    getdegreeData();
    var gender = controller.selectedGender;
    var gendera = controller.selectedGender;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: !controller.isDataLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ))
              : Container(
                  width: deviceWidth,
                  // height: deviceHeight,
                  padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              elevation: 10,
                              // gives rounded corner to modal bottom screen
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: deviceHeight * 0.02,
                                    ),
                                    const Text('Tap below Option to Pic image'),
                                    SizedBox(
                                      height: deviceHeight * 0.02,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          chooseImage('camera');
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Camera')),
                                    TextButton(
                                        onPressed: () {
                                          chooseImage('gallery');
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Gallery')),
                                    SizedBox(
                                      height: deviceHeight * 0.05,
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          // elevation: 2,
                          // shape: const CircleBorder(),
                          child: CircleAvatar(
                            // backgroundColor: AppTheme.primaryColor,
                            radius: 50,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: controller.selectedImage == null ? controller.model.value.data!.profileImage
                                            .isEmpty
                                        ? const Icon(
                                            Icons.camera_alt,
                                            size: 24,
                                            color: Colors.white,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: controller
                                                .model.value.data!.profileImage,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )
                                    : Image.file(
                                  controller.selectedImage!,
                                        fit: BoxFit.cover,
                                        width: deviceWidth,
                                        height: deviceHeight,
                                      )),
                          ),
                        ),
                        Text(
                          controller.model.value.data!.name.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1.8),
                        ),
                        Text(
                          controller.model.value.data!.email.toString(),
                          style: const TextStyle(
                              color: AppTheme.greyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            heightFactor: 1.5,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 2),
                            )),
                        Tok2DocTextField(
                            // onTap: onTap,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Name  is required'),
                            ]),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            controller: controller.nameController,
                            hintText: "Enter Name",
                            obscureText: false.obs),
                        const Align(
                            alignment: Alignment.centerLeft,
                            heightFactor: 1.5,
                            child: Text(
                              "Mobile Number",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 2),
                            )),
                        Tok2DocTextField(
                            // onTap: onTap,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Mobile number  is required'),
                              MinLengthValidator(8,
                                  errorText:
                                      'mobile number must be at least 10 digits long'),
                            ]),
                            controller: controller.mobileController,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            hintText: "Enter Mobile Number",
                            obscureText: false.obs),
                        const Align(
                            alignment: Alignment.centerLeft,
                            heightFactor: 1.5,

                            child: Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 2),
                            )),
                        Tok2DocTextField(
                            // onTap: onTap,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Email  is required'),
                              EmailValidator(errorText: "Enter valid email"),
                            ]),
                            controller: controller.emailController,
                            enabled: true,
                            hintText: "Enter Email",
                            obscureText: false.obs),
                        alignUserFields(
                            "Date of Birth", 'YYYY-MM-DD',
                            controller.dobController, () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate == null) {
                            controller.dobController.text =
                                DateFormat('yyyy-MM-dd')
                                    .format(pickedDate!)
                                    .toString();
                          } else {
                            controller.dobController.text =
                                DateFormat('yyyy-MM-dd')
                                    .format(pickedDate!)
                                    .toString();
                          }
                        }),
                        const Align(
                            alignment: Alignment.centerLeft,
                            heightFactor: 1.5,
                            child: Text(
                              "Experience",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 2),
                            )),
                        Tok2DocTextField(
                            // onTap: onTap,
                            //keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Experience  is required'),
                            ]),
                            controller: controller.experienceController,
                            enabled: true,
                            keyboardType: TextInputType.number,
                            hintText: "Experience".toString(),
                            obscureText: false.obs),
                        const Align(
                            alignment: Alignment.centerLeft,
                            heightFactor: 1.5,
                            child: Text(
                              'Gender',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 2),
                            )),
                        Container(
                          height: 60,
                          padding: const EdgeInsets.only(left: 12.0),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(12.0),
                            // border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: const Text('Select Gender'),
                              // Not necessary for Option 1
                              value: controller.selectedGender == ""
                                  ? null
                                  : controller.selectedGender,
                              onChanged: (newValue) {
                                setState(() {
                                  controller.selectedGender =
                                  newValue as String?;
                                });
                              },
                              items: controller.genderList.map((location) {
                                return DropdownMenuItem(
                                  value: location,
                                  child: Text(location),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            heightFactor: 1.5,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Category',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 2),
                              ),
                            )),
                        Container(
                          height: 55,
                          width: deviceWidth,
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          decoration: BoxDecoration(
                            // color: AppTheme.primaryColor.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: Obx(() {
                            return !_categoryListController.isDataLoading.value
                                ? CircularProgressIndicator()
                                : Container(
                                    height: 65,
                                    padding: const EdgeInsets.only(left: 12.0),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor
                                          .withOpacity(0.04),
                                      borderRadius: BorderRadius.circular(12.0),
                                      // border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<dynamic>(
                                        isExpanded: true,
                                        hint: const Text('Select Category'),
                                        // Not necessary for Option 1
                                        value: controller.selectedCategory == "" ? null
                                            : controller.selectedCategory,
                                        onChanged: (newValue) {
                                          setState(() {
                                            controller.selectedCategory =
                                                newValue as String?;
                                          });
                                        },
                                        items: _categoryListController
                                            .model.value.data!
                                            .map((value) {
                                          return DropdownMenuItem(
                                            value: value.id.toString(),
                                            child: Text(
                                              value.name,
                                              style: const TextStyle(
                                                  color: Color(0xff9C9CB4)),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                          }),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            heightFactor: 1.5,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Specialist',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 2),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(MyRouter.editSpecialistScreen);
                                  },
                                  child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor:
                                          AppTheme.greyColor.withOpacity(0.2),
                                      child:
                                          Image.asset("assets/icon/edit.png")),
                                )
                              ],
                            )),
                        ListView(
                          primary: true,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            Container(
                              width: deviceWidth,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                // color: AppTheme.primaryColor.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 0.80),
                              ),
                              child:  Wrap(
                                spacing: 16.0,
                                runSpacing: 0.0,
                                children: List<Widget>.generate(
                                    controller.model.value.data!.specialist
                                        .length, (int index) {
                                  return Chip(
                                      backgroundColor: const Color(0xffF5F5F5),
                                      label: Text(controller.model.value.data!
                                          .specialist[index].specialistname
                                          .toString()));
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            heightFactor: 1.5,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Medical Degrees',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 2),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(MyRouter.addMedicalDegreesScreen);
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor:
                                        AppTheme.greyColor.withOpacity(0.2),
                                    child: Image.asset("assets/icon/edit.png"),
                                  ),
                                )
                              ],
                            )),
                        ListView(
                          primary: true,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            Container(
                              width: deviceWidth,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                // color: AppTheme.primaryColor.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 0.80),
                              ),
                              child: Wrap(
                                spacing: 16.0,
                                runSpacing: 0.0,
                                children:
                                List<Widget>.generate(1, (int index) {
                                  return Chip(
                                      backgroundColor: const Color(0xffF5F5F5),
                                      label: Text(degree.toString()));
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 8.0),
                            child: const Text(
                              'About Me',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: controller.aboutController,
                          /*obscureText: true,*/
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "About me",
                            fillColor: AppTheme.primaryColor.withOpacity(0.04),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.05,
                        ),
                        Obx(() {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Document 1',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          NewHelper()
                                              .addFilePicker()
                                              .then((value) {
                                            document1.value = value;
                                          });
                                          // var picked = await FilePicker.platform.pickFiles(
                                          //   type: FileType.custom,
                                          //   allowedExtensions: ['pdf', 'doc'],
                                          // );
                                          //
                                          // if (picked != null) {
                                          //   var nameFull =
                                          //       picked.files.first.name;
                                          //   documentName1 = nameFull;
                                          //   documentPath1 =
                                          //       File(picked.files.first.path!);
                                          //   setState(() {
                                          //     var nameFull =
                                          //         picked.files.first.name;
                                          //     documentName1 = nameFull;
                                          //     documentPath1 =
                                          //         File(picked.files.first.path!);
                                          //   });
                                          //   print(picked.files.first.name);
                                          //   print(picked.files.first.path);
                                          // } else {
                                          //   // User canceled the picker
                                          // }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(55),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: const Color(0xffc4c4c4),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Icon(Icons
                                                    .file_upload_outlined)),
                                          ),
                                        ),
                                      ),
                                      //documentName1.toString() ? Text('') : Container(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      document1.value.path == ""
                                          ? Text(
                                              controller.names[0],
                                              // .toString()
                                              // .split("/")
                                              // .last,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : Text(
                                              document1.value.path
                                                  .toString()
                                                  .split("/")
                                                  .last,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),

                                      // documentName1.toString() == null
                                      //     ? Text('')
                                      //     : Container(
                                      //         child: Text(
                                      //           documentName1.toString(),
                                      //           overflow: TextOverflow.ellipsis,
                                      //           textAlign: TextAlign.start,
                                      //           style: TextStyle(
                                      //               fontSize: 14,
                                      //               fontWeight: FontWeight.w500),
                                      //         ),
                                      //       ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Document 2',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          NewHelper()
                                              .addFilePicker()
                                              .then((value) {
                                            document2.value = value;
                                          });
                                          // var picked = await FilePicker.platform.pickFiles(
                                          //   type: FileType.custom,
                                          //   allowedExtensions: ['pdf', 'doc'],
                                          // );
                                          //
                                          // if (picked != null) {
                                          //   var nameFull =
                                          //       picked.files.first.name;
                                          //   documentName1 = nameFull;
                                          //   documentPath1 =
                                          //       File(picked.files.first.path!);
                                          //   setState(() {
                                          //     var nameFull =
                                          //         picked.files.first.name;
                                          //     documentName1 = nameFull;
                                          //     documentPath1 =
                                          //         File(picked.files.first.path!);
                                          //   });
                                          //   print(picked.files.first.name);
                                          //   print(picked.files.first.path);
                                          // } else {
                                          //   // User canceled the picker
                                          // }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(55),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: const Color(0xffc4c4c4),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Icon(Icons
                                                    .file_upload_outlined)),
                                          ),
                                        ),
                                      ),
                                      //documentName1.toString() ? Text('') : Container(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      document2.value.path == ""
                                          ? Text(
                                              controller.names[1],
                                              // .toString()
                                              // .split("/")
                                              // .last,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : Text(
                                              document2.value.path
                                                  .toString()
                                                  .split("/")
                                                  .last,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),

                                      // documentName1.toString() == null
                                      //     ? Text('')
                                      //     : Container(
                                      //         child: Text(
                                      //           documentName1.toString(),
                                      //           overflow: TextOverflow.ellipsis,
                                      //           textAlign: TextAlign.start,
                                      //           style: TextStyle(
                                      //               fontSize: 14,
                                      //               fontWeight: FontWeight.w500),
                                      //         ),
                                      //       ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Document 3',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          NewHelper()
                                              .addFilePicker()
                                              .then((value) {
                                            document3.value = value;
                                          });
                                          // var picked = await FilePicker.platform.pickFiles(
                                          //   type: FileType.custom,
                                          //   allowedExtensions: ['pdf', 'doc'],
                                          // );
                                          //
                                          // if (picked != null) {
                                          //   var nameFull =
                                          //       picked.files.first.name;
                                          //   documentName1 = nameFull;
                                          //   documentPath1 =
                                          //       File(picked.files.first.path!);
                                          //   setState(() {
                                          //     var nameFull =
                                          //         picked.files.first.name;
                                          //     documentName1 = nameFull;
                                          //     documentPath1 =
                                          //         File(picked.files.first.path!);
                                          //   });
                                          //   print(picked.files.first.name);
                                          //   print(picked.files.first.path);
                                          // } else {
                                          //   // User canceled the picker
                                          // }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(55),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: const Color(0xffc4c4c4),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Icon(Icons
                                                    .file_upload_outlined)),
                                          ),
                                        ),
                                      ),
                                      //documentName1.toString() ? Text('') : Container(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      document3.value.path == ""
                                          ? Text(
                                              controller.names[2],
                                              // .toString()
                                              // .split("/")
                                              // .last,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : Text(
                                              document3.value.path
                                                  .toString()
                                                  .split("/")
                                                  .last,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),

                                      // documentName1.toString() == null
                                      //     ? Text('')
                                      //     : Container(
                                      //         child: Text(
                                      //           documentName1.toString(),
                                      //           overflow: TextOverflow.ellipsis,
                                      //           textAlign: TextAlign.start,
                                      //           style: TextStyle(
                                      //               fontSize: 14,
                                      //               fontWeight: FontWeight.w500),
                                      //         ),
                                      //       ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Document 4',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          NewHelper()
                                              .addFilePicker()
                                              .then((value) {
                                            document4.value = value;
                                          });
                                          // var picked = await FilePicker.platform.pickFiles(
                                          //   type: FileType.custom,
                                          //   allowedExtensions: ['pdf', 'doc'],
                                          // );
                                          //
                                          // if (picked != null) {
                                          //   var nameFull =
                                          //       picked.files.first.name;
                                          //   documentName1 = nameFull;
                                          //   documentPath1 =
                                          //       File(picked.files.first.path!);
                                          //   setState(() {
                                          //     var nameFull =
                                          //         picked.files.first.name;
                                          //     documentName1 = nameFull;
                                          //     documentPath1 =
                                          //         File(picked.files.first.path!);
                                          //   });
                                          //   print(picked.files.first.name);
                                          //   print(picked.files.first.path);
                                          // } else {
                                          //   // User canceled the picker
                                          // }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(55),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: const Color(0xffc4c4c4),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Icon(Icons
                                                    .file_upload_outlined)),
                                          ),
                                        ),
                                      ),
                                      //documentName1.toString() ? Text('') : Container(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      document4.value.path == ""
                                          ? Text(
                                              controller.names[3],
                                              // .toString()
                                              // .split("/")
                                              // .last,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : Text(
                                              document4.value.path
                                                  .toString()
                                                  .split("/")
                                                  .last,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),

                                      // documentName1.toString() == null
                                      //     ? Text('')
                                      //     : Container(
                                      //         child: Text(
                                      //           documentName1.toString(),
                                      //           overflow: TextOverflow.ellipsis,
                                      //           textAlign: TextAlign.start,
                                      //           style: TextStyle(
                                      //               fontSize: 14,
                                      //               fontWeight: FontWeight.w500),
                                      //         ),
                                      //       ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        Tok2DocButton(AppStrings.updateProfile, () {
                          if (_formKey.currentState!.validate()) {

                            var meDegrees = '';
                            // for (var specilist
                            //     in controller.model.value.data!.specialist) {
                            //   if (splist == '') {
                            //     splist = specilist.id.toString();
                            //   } else {
                            //     splist = splist + ',' + specilist.id.toString();
                            //     print("splist::" + splist);
                            //   }
                            // }

                            for (var degrees in controller.model.value.data!.medicalDegree) {
                              if (meDegrees == '') {
                                meDegrees = degrees.id.toString();
                              } else {
                                meDegrees = '$meDegrees,${degrees.id}';
                              }
                            }

                            print("""object""");
                            // showLoadingIndicatorDialog(context);
                            updateDoctorRegister(
                              context,
                              controller.nameController.text,
                              controller.emailController.text,
                              controller.mobileController.text,
                              controller.dobController.text,
                              controller.experienceController.text,
                              controller.selectedGender ??
                                  controller.model.value.data!.gender,
                              controller.selectedCategory ?? categreeId,
                              controller.specialistValue,
                              "data:image/jpg;base64,${controller.base64Image}",
                              controller.aboutController.text,
                              degreeId,
                              ConcentrationId,
                              institutionName,
                              document1: document1.value,
                              document2: document2.value,
                              document3: document3.value,
                              document4: document4.value,
                            ).then((value) {
                              if (value.status) {
                                controller.getData();
                                // getProfileData();
                                Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) =>  BottomNavBarCustom(1)),
                                     );
                                showToast(value.message);
                              }
                              return null;
                            });
                          } else {
                            //showToast(value.message);
                            showToast("profile not Updated");
                          }
                        }),
                        SizedBox(
                          height: deviceHeight * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }

  Widget alignUserFields(
      String fieldName, hintText, TextEditingController controller, onTap) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            heightFactor: 1.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                fieldName,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500, height: 2),
              ),
            )),
        Tok2DocTextField(
            onTap: onTap,
            controller: controller,
            validator: MultiValidator([
              RequiredValidator(errorText: '$fieldName is required'),
            ]),
            hintText: hintText,
            obscureText: false.obs),
      ],
    );
  }

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
    } else {
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    }
    if (image != null) {
      setState(() {
        controller.selectedImage = File(image.path);
        controller.base64Image = base64Encode(controller.selectedImage!.readAsBytesSync());
        // print("object$base64Image");
      });
    }
  }

  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    // if no file is picked
    if (result == null) return;

    // we get the file from result object
    final file = result.files;

    // _openFile(file);
  }
}
