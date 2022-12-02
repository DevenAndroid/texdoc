import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/controller/medical_degree_conversation_list_controller.dart';
import 'package:texdoc/repository/medical_degree_update_repository.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:texdoc/screens/my_profile_screen.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';

import '../../controller/get-user-profile_controller.dart';
import '../../models/api_models/model_degree_&_concentration_response.dart';
import 'complete_profile.dart';

class AddMedicalDegreesScreen extends StatefulWidget {
  const AddMedicalDegreesScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicalDegreesScreen> createState() =>
      _AddMedicalDegreesScreenState();
}

class _AddMedicalDegreesScreenState extends State<AddMedicalDegreesScreen> {
  UserProfileController _profileController = Get.put(UserProfileController());
  MedicalDegreeConversationListController controller = Get.put(MedicalDegreeConversationListController());

  final _formKey = GlobalKey<FormState>();
  TextEditingController instituteController = TextEditingController();

  // String? selectedDegree = "";
  // String? selectedMajorGroup = "";

  String selectedDegree = "";
  String selectedID = "";
  String selectedName = "";
  String concentrationId = "";
  String concentrationName = "";
  String selectedMajorGroup = "";
  MedicalDegree? degree;
  Concentration? concentration;




  int ? degreeId;
  String institutionName = "";


  @override
  void initState() {
    super.initState();
    getdegreeData();
  }

  getdegreeData() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    if(instituteController.text!=null)
      {
        instituteController.text = pref.getString("institutionName")!;
      }
    institutionName = pref.getString("institutionName")!;
    var ddegreeId = pref.getString("DegreeId")!;
    degreeId = int.parse(ddegreeId);
    //ConcentrationId = pref.getString("concentrationId")!;
    print("degree---------    ${degree}");
  /*  print("concentration---------    ${concentration}");
    print("institutionName---------    ${institutionName}");
    print("degreeId---------    ${degreeId}");
    print("ConcentrationId---------    ${ConcentrationId}");*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: const Text("Add Medical Degrees"),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )),
      body: Obx(() {
        return controller.isDataLoading.value
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Add Medical Degrees',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor:
                                  AppTheme.greyColor.withOpacity(0.5),
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: AppTheme.primaryColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 8.0),
                            child: const Text(
                              'Name of Degree',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          height: 8.h,
                        ),
                     /*   Container(
                          height: 55,
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<MedicalDegree>(
                              isExpanded: true,
                              hint: const Text(
                                  'Select degree'), // Not necessary for Option 1
                              value: degree, *//*== null? degree:degree,*//*
                              onChanged: (value) {

                                setState(() {
                                  degree = value;
                                  selectedDegree = value!.medicaldegree;
                                  selectedID = value.id.toString();
                                  print(selectedDegree);
                                  print(selectedID);
                                });
                              },
                              items: controller.model.value.data!.medicalDegree
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value.medicaldegree,
                                    style: const TextStyle(
                                        color: Color(0xff9C9CB4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),*/
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 8.0),
                            child: const Text(
                              'Concentration/Major/Group',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          height: 8.h,
                        ),
                     /*   Container(
                          height: 55,
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Concentration>(
                              isExpanded: true,
                              hint: const Text(
                                  "Select Concentration"), // Not necessary for Option 1
                              value: concentration ?? null,
                              onChanged: (value) {
                                setState(() {
                                  concentration = value;
                                  concentrationName = value!.concentration;
                                  concentrationId = value.id.toString();
                                  print(concentrationName);
                                  print(concentrationId);
                                });
                              },
                              items: controller.model.value.data?.concentration
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value.concentration,
                                    style: const TextStyle(
                                        color: Color(0xff9C9CB4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),*/
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 8.0),
                            child: const Text(
                              'Institution Name',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormField(
                          controller: instituteController,
                          obscureText: false,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'institution name is required'),
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Enter Institution Name',
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
                          height: 40.h,
                        ),
                        Tok2DocButton(AppStrings.save, () async {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          //pref.getString("document_verified");
                          if (_formKey.currentState!.validate()) {
                            if (selectedDegree == "") {
                              showToast("please Select degree");
                            } else if (concentrationId == "") {
                              showToast(
                                  "please select Concentration/Major/Group");
                            } else {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              var degree = pref.setString(
                                  "DegreeName", selectedDegree.toString());
                              var ConcentrationName = pref.setString(
                                  "ConcentrationName",
                                  concentrationName.toString());
                              var institutionName = pref.setString(
                                  "institutionName",
                                  instituteController.text.toString());
                              var ConcentrationId = pref.setString(
                                  "concentrationId",
                                  concentrationId.toString());
                              var SelectedID = pref.setString(
                                  "DegreeId",
                                  selectedID);
                              //Get.back();
                              if(pref.getString('user') != null && pref.getBool("document_verified") == true)
                                {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => const MyProfileScreen()),
                                  // );
                                  
                                  Get.offAndToNamed(
                                      MyRouter.myProfileScreen,  arguments: [degree, ConcentrationName,institutionName,ConcentrationId,SelectedID]
                                  );
                                }
                              else
                                {
                                  Get.offAndToNamed (
                                      MyRouter.completeProfileScreen,  arguments: [degree, ConcentrationName,institutionName,ConcentrationId,SelectedID]
                                  );
                                }

                             /* Get.toNamed(
                                  MyRouter.myProfileScreen,  arguments: [degree, ConcentrationName,institutionName,ConcentrationId,SelectedID]
                              );*/

                              // medicalDegreeUpdate(context, selectedDegree.toString(), selectedMajorGroup.toString(), instituteController.text).then((value) async {
                              /*if(value.status==true){
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString('Degree', jsonEncode(selectedDegree.toString()));
                                _profileController.getData();
                                _profileController.getData();
                                showToast(value.message);
                               // Get.toNamed(MyRouter.setTimeScreen);
                              }
                              return null;
                            });*/
                            }
                          }
                        })
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ));
      }),
    );
  }
}
