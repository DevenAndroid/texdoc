import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/controller/category_list_controller.dart';
import 'package:texdoc/controller/get-user-profile_controller.dart';
import 'package:texdoc/repository/update-doctor-register_repository.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/new_helper.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:texdoc/widgets/tok2DocTextField.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../app_utils/api_constant.dart';
import '../../controller/doctor_Speciality_list_controller.dart';
import '../../models/api_models/model_degree_&_concentration_response.dart';
import '../../models/api_models/model_login_response.dart';
import '../../models/api_models/model_speciality_list_response.dart';
import '../../repository/speciality_update_repository.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  List<String> _myActivities = [];
  String? _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  // profileController
  UserProfileController controller = Get.put(UserProfileController());
  final CategoryListController _categoryListController =
  Get.put(CategoryListController());

  final _formKey = GlobalKey<FormState>();

  //SpecialityListController controllera = Get.put(SpecialityListController());
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

  // SpecialityListController _controllera = Get.put(SpecialityListController());

  String specialistValue = "";
  String degreeslistValue = "";


  List<String> DegreeList = ['MBBS', 'BDS', 'BAMS', 'BHMS', 'BUMS', 'BYNS'];

  UserProfileController _profileController = Get.put(UserProfileController());

  var degree = "";
  var concentration;
  var institutionName;
  var degreeId;
  var ConcentrationId;

  MedicalDegree? degreenew;
  var splist = '';

  showSpecialistDialogue() {
    showDialog(context: context, builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: MediaQuery
            .of(context)
            .size
            .height * .14),
        child: Obx(() {
          return _profileController.specialistLoaded.value ?
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("    Select Specialty", style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),),
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: const Icon(Icons.clear))
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _profileController.specialistModel
                        .value
                        .data!.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      _profileController
                                          .specialistModel
                                          .value
                                          .data![index]
                                          .specialistname
                                          .toString())),
                              Checkbox(
                                  value: _profileController
                                      .specialistModel
                                      .value.data![index].selected!
                                      .value,
                                  onChanged: (value) {
                                    _profileController
                                        .specialistModel.value
                                        .data![index].selected!
                                        .value =
                                    value!;
                                    _profileController.specialistShowListData
                                        .clear();
                                    for (var item in _profileController
                                        .specialistModel.value.data!) {
                                      if (item.selected!.value) {
                                        _profileController
                                            .specialistShowListData.add(
                                            item.specialistname.capitalize
                                                .toString());
                                      }
                                    }
                                  })
                            ],
                          ),
                        );
                      });
                    }),
              )
            ],
          ) :
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20,),
                Text("Loading Please wait...")
              ],
            ),
          );
        }),
      );
    });
  }

  showDegreeDialogue() {
    showDialog(context: context, builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          return _profileController.degreelistLoading.value ?
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("    Select Specialty", style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),),
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: const Icon(Icons.clear))
                ],
              ),
              ListView.builder(
                  itemCount: _profileController.degreelistModel
                      .value
                      .data!.medicalDegree!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    MedicalDegree item = _profileController.degreelistModel
                        .value
                        .data!.medicalDegree![index];
                    return Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                    item
                                        .medicaldegree
                                        .toString())),
                            Checkbox(
                                value: item.selected!
                                    .value,
                                onChanged: (value) {
                                  _profileController
                                      .degreelistModel.value
                                      .data!.medicalDegree![index].selected!
                                      .value =
                                  value!;
                                  _profileController.degreeShowListData
                                      .clear();
                                  for (var item in _profileController
                                      .degreelistModel.value.data!.medicalDegree!) {
                                    if (item.selected!.value) {
                                      _profileController.degreeShowListData
                                          .add(item.medicaldegree!.capitalize
                                          .toString());
                                    }
                                  }
                                })
                          ],
                        ),
                      );
                    });
                  })
            ],
          ) :
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20,),
                Text("Loading Please wait...")
              ],
            ),
          );
        }),
      );
    });
  }


  @override
  void initState() {
    super.initState();
    controller.getData();
    setState(() {});
  }

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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: const Text("Complete Your Profile"),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )),
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
                  /*Column(
                          children: [
                            GestureDetector(onTap: (){
                              showDialog(
                                  context: context,

                                  builder: (BuildContext context) {
                                    return Dialog(

                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0)), //this right here
                                      child: SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 15),
                                          child: Column(
                                            children: [
                                              ...List.generate(
                                                  _controllera.model.value.data!.length,
                                                      (index) =>
                                                      Container(
                                                        margin: const EdgeInsets.only(bottom: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            border: Border.all(
                                                                color: _controllera.model.value.data![index].isselected == true
                                                                    ? AppTheme.primaryColor
                                                                    : AppTheme.greyColor
                                                            )
                                                        ),
                                                        child: CheckboxListTile(
                                                            checkColor: Colors.white,
                                                            activeColor: AppTheme.primaryColor,
                                                            contentPadding: const EdgeInsets.all(0),
                                                            controlAffinity: ListTileControlAffinity.leading,
                                                            // title: Text(checkListItems[index]["title"]),
                                                            title: Text(_controllera.model.value.data![index].specialistname),
                                                            value: _controllera.model.value.data![index].isselected,
                                                            onChanged: (value) {
                                                              _controllera.model.value.data![index].isselected = value;
                                                              // if(controller.model.value.data![index].isselected)
                                                              //   {
                                                              //     controller.multipleSelected.add(controller.model.value.data![index].id);
                                                              //     setState(() {
                                                              //
                                                              //     });
                                                              //   }
                                                              // else
                                                              //   {
                                                              //     controller.multipleSelected.remove(controller.model.value.data![index].id);
                                                              //     setState(() {
                                                              //
                                                              //     });
                                                              //   }
                                                              setState(() {});
                                                              setState(() {});
                                                            }
                                                        ),
                                                      )),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              Tok2DocButton(AppStrings.save, () {
                                                // String selectedSpecilist = "";
                                                _profileController.specialistValue = "";
                                                for(var item in _controllera.model.value.data!){
                                                  if(item.isselected == true) {
                                                    if (_profileController.specialistValue == "") {
                                                      _profileController.specialistValue = item.id.toString();
                                                    }
                                                    else {
                                                      _profileController.specialistValue =
                                                          _profileController.specialistValue + "," + item.id.toString();
                                                    }
                                                  }
                                                }
                                                print(_profileController.specialistValue);
                                                if (_profileController.specialistValue == "") {
                                                  showSnackBar('Edit Speciality Status',
                                                      'Please Select atLeast on speciality.');
                                                }
                                                else {
                                                  // print("dngjfhdnjgjfg$selectedSpecilist");
                                                  showLoadingIndicatorDialog(context);
                                                  doctorSpecialityUpdate(context, _profileController.specialistValue.toString(),
                                                  ).then((value) {
                                                    // _profileController.specialistValue = selectedSpecilist;
                                                    showToast(value.message);
                                                    if (value.status == true) {
                                                      _profileController.getData();
                                                      // for(var item in _profileController.model.value.data!.specialist){
                                                      //   item.
                                                      // };
                                                      setState(() {

                                                      });
                                                      Navigator.pop(context);
                                                    }
                                                    return null;
                                                  });
                                                }
                                              })
                                            ],
                                          ),
                                        ),
                                      )
                                    );
                                  });
                            },child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Add Specialist',
                                  style: TextStyle(
                                      height: 3.0,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )),),

                         */
                  /*   SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                              height: 40,
                            ),*/ /*
                           */
                  /* Tok2DocButton(AppStrings.save, () {
                              // String selectedSpecilist = "";
                              _profileController.specialistValue = "";
                              for(var item in controller.model.value.data!){
                                if(item.isselected == true) {
                                  if (_profileController.specialistValue == "") {
                                    _profileController.specialistValue = item.id.toString();
                                  }
                                  else {
                                    _profileController.specialistValue =
                                        _profileController.specialistValue + "," + item.id.toString();
                                  }
                                }
                              }
                              print(_profileController.specialistValue);
                              if (_profileController.specialistValue == "") {
                                showSnackBar('Edit Speciality Status',
                                    'Please Select atLeast on speciality.');
                              }
                              else {
                                // print("dngjfhdnjgjfg$selectedSpecilist");
                                showLoadingIndicatorDialog(context);
                                doctorSpecialityUpdate(context, _profileController.specialistValue.toString(),
                                ).then((value) {
                                  // _profileController.specialistValue = selectedSpecilist;
                                  showToast(value.message);
                                  if (value.status == true) {
                                    _profileController.getData();
                                    // for(var item in _profileController.model.value.data!.specialist){
                                    //   item.
                                    // };
                                    setState(() {

                                    });
                                    Navigator.pop(context);
                                  }
                                  return null;
                                });
                              }
                            })*/
                  /*
                          ],
                        ),*/
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
                          child: controller.selectedImage == null
                              ? controller.model.value.data!.profileImage
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
                      //enabled: t,
                      hintText: "Enter Email",
                      obscureText: false.obs),
                  alignUserFields("Date of Birth", 'YYYY-MM-DD',
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
                                  .format(pickedDate)
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
                  /* Container(
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
                  ),*/
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
                          ? const CircularProgressIndicator()
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
                            value: controller.selectedCategory == ""
                                ? null
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Align(
                          alignment: Alignment.centerLeft,
                          heightFactor: 1.5,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Degree',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 2),
                            ),
                          )),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      showDegreeDialogue();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(14)
                      ),
                      width: double.maxFinite,
                      constraints: const BoxConstraints(
                          minHeight: 54
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: _profileController
                                    .degreeShowListData.map((element) =>
                                    Text(element + ",",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),)).toList(),
                              );
                            }),
                          ),
                          const Icon(Icons.arrow_drop_down_outlined, size: 26,)
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Align(
                          alignment: Alignment.centerLeft,
                          heightFactor: 1.5,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Specialist',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 2),
                            ),
                          )),
                    ],
                  ),

                  InkWell(
                    onTap: () {
                      showSpecialistDialogue();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(14)
                      ),
                      width: double.maxFinite,
                      constraints: const BoxConstraints(
                          minHeight: 54
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: _profileController
                                  .specialistShowListData.map((element) =>
                                  Text(element + ",", style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),)).toList(),
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down_outlined, size: 26,)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  // if(showSpecialist.value)
                  // // Obx(() {
                  // //   return Wrap(
                  // //     runSpacing: 2,
                  // //     spacing: 6,
                  // //     children: _profileController.specialistModel.value
                  // //         .data!.map((e) =>
                  // //         FilterChip(
                  // //             label: Text(e.specialistname.toString(),style: TextStyle(
                  // //                 color: e.selected!.value ? Colors.white : Colors.black
                  // //             ),),
                  // //             checkmarkColor: Colors.white,
                  // //             selected: e.selected!.value,
                  // //             selectedColor: Colors.lightBlue.shade800,
                  // //             backgroundColor: Colors.grey.shade200,
                  // //             onSelected: (value) {
                  // //               e.selected!.value = value;
                  // //             })).toList(),
                  // //   );
                  // // }),
                  //   Column(
                  //     children: [
                  //       if(_profileController.specialistLoaded.value)
                  //         Obx(() {
                  //           return Container(
                  //             height: 300,
                  //             child:,
                  //           );
                  //         }),
                  //     ],
                  //   ),
                  const SizedBox(
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
                  const SizedBox(
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
                                const Text(
                                  'Document 1',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
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
                                    padding: const EdgeInsets.all(55),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF5F5F5),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffc4c4c4),
                                        borderRadius:
                                        BorderRadius.circular(50),
                                      ),
                                      child: const Align(
                                          alignment:
                                          Alignment.bottomCenter,
                                          child: Icon(Icons
                                              .file_upload_outlined)),
                                    ),
                                  ),
                                ),
                                //documentName1.toString() ? Text('') : Container(),
                                const SizedBox(
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
                                  style: const TextStyle(
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
                                  style: const TextStyle(
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
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Document 2',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    NewHelper()
                                        .addFilePicker()
                                        .then((value) {
                                      document2.value = value;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(55),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF5F5F5),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffc4c4c4),
                                        borderRadius:
                                        BorderRadius.circular(50),
                                      ),
                                      child: const Align(
                                          alignment:
                                          Alignment.bottomCenter,
                                          child: Icon(Icons
                                              .file_upload_outlined)),
                                    ),
                                  ),
                                ),
                                //documentName1.toString() ? Text('') : Container(),
                                const SizedBox(
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
                                  style: const TextStyle(
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
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
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
                                const Text(
                                  'Document 3',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    NewHelper()
                                        .addFilePicker()
                                        .then((value) {
                                      document3.value = value;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(55),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF5F5F5),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffc4c4c4),
                                        borderRadius:
                                        BorderRadius.circular(50),
                                      ),
                                      child: const Align(
                                          alignment:
                                          Alignment.bottomCenter,
                                          child: Icon(Icons
                                              .file_upload_outlined)),
                                    ),
                                  ),
                                ),
                                //documentName1.toString() ? Text('') : Container(),
                                const SizedBox(
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
                                  style: const TextStyle(
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
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Document 4',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    NewHelper()
                                        .addFilePicker()
                                        .then((value) {
                                      document4.value = value;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(55),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF5F5F5),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffc4c4c4),
                                        borderRadius:
                                        BorderRadius.circular(50),
                                      ),
                                      child: const Align(
                                          alignment:
                                          Alignment.bottomCenter,
                                          child: Icon(Icons
                                              .file_upload_outlined)),
                                    ),
                                  ),
                                ),
                                //documentName1.toString() ? Text('') : Container(),
                                const SizedBox(
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
                                  style: const TextStyle(
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
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Tok2DocButton(AppStrings.updateProfile, () {
                    if (_formKey.currentState!.validate()) {
                      var splist = '';
                      var meDegrees = '';
                      // for (var specilist in specialistList) {
                      //   if (splist == '') {
                      //     splist = specilist;
                      //   } else {
                      //     splist = splist + ',' + specilist;
                      //     print("splist::" + splist);
                      //   }
                      // }
                      specialistValue = "";
                      for (var item in _profileController.specialistModel.value
                          .data!) {
                        if (item.selected!.value) {
                          if (specialistValue == "") {
                            specialistValue = item.id.toString();
                          } else {
                            specialistValue =
                                specialistValue + "," + item.id.toString();
                          }
                        }
                      }
                      degreeslistValue = "";
                      for (var item in _profileController.degreelistModel.value
                          .data!.medicalDegree!) {
                        if (item.selected!.value) {
                          if (degreeslistValue == "") {
                            degreeslistValue = item.id.toString();
                          } else {
                            degreeslistValue =
                                degreeslistValue + "," + item.id.toString();
                          }
                        }
                      }

                      for (var degrees
                      in DegreeList) {
                        if (meDegrees == '') {
                          meDegrees = degrees.toString();
                        } else {
                          meDegrees = '$meDegrees,${degrees}';
                        }
                      }

                      print("""object""");
                      // showLoadingIndicatorDialog(context);

                      if (controller.selectedGender == "") {
                        showToast("Please select Gender");
                      } else if (controller.selectedCategory == "") {
                        showToast("Please select Category");
                      }
                      /*else if (degreeId == null) {
                        showToast("Please select degree");
                      } */ else {
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
                          specialistValue,
                          "data:image/jpg;base64,${controller.base64Image}",
                          controller.aboutController.text,
                          degreeslistValue,
                          "1",
                          "gr",
                          document1: document1.value,
                          document2: document2.value,
                          document3: document3.value,
                          document4: document4.value,
                        ).then((value) {
                          if (value.status) {
                            controller.getData();
                            // getProfileData();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Welcome'),
                                    // To display the title it is optional
                                    content: const Text(
                                        'Thanks for completing your profile, we will get back to you shortly with your profile approval update '),
                                    // Message which will be pop up on the screen
                                    // Action widget which will provide the user to acknowledge the choice
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.offAllNamed(
                                              MyRouter.loginScreen);
                                          // Navigator.pop(context);
                                        },
                                        child: const Text('ACCEPT'),
                                      ),
                                    ],
                                  );
                                });
                          }
                          return null;
                        });
                      }

                      /*if (degreeId != null) {


                            } else {
                              showToast("Please select degree");
                            }*/
                    } else {
                      // showToast("profile not Updated");
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

/*  Widget getListView() {
    return ListView.builder(
      itemCount: _myActivities!.length,
      itemBuilder: (context, index){
        return cardView(_myActivities![index]);
      },
    );
  }
  Widget cardView(item) {

    var fullName = item;

    return MultiSelectDialogField(
      items:fullName,
      title: Text("Animals"),
      selectedColor: Colors.blue,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(40)),
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
      ),
      buttonIcon: Icon(
        Icons.pets,
        color: Colors.blue,
      ),
      buttonText: Text(
        "Favorite Animals",
        style: TextStyle(
          color: Colors.blue[800],
          fontSize: 16,
        ),
      ),
      onConfirm: (results) {
       // _myActivities = results;
      },
    );
  }*/

  Widget alignUserFields(String fieldName, hintText,
      TextEditingController controller, onTap) {
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
        controller.base64Image =
            base64Encode(controller.selectedImage!.readAsBytesSync());
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
