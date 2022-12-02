import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:texdoc/models/api_models/model_user_profile_response.dart';
import 'package:texdoc/repository/get-user-profile_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/api_models/model_degree_&_concentration_response.dart';
import '../models/api_models/model_speciality_list_response.dart';
import '../repository/doctor_Speciality_list_repository.dart';
import '../repository/medical_&_conversation_list_repository.dart';
import '../repository/medical_degree_update_repository.dart';

class UserProfileController extends GetxController {
  Rx<ModelUserProfileResponse> model = ModelUserProfileResponse().obs;
  RxBool isDataLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  String? selectedCategory;
  String? selectedGender;
  File? selectedImage;
  String? base64Image;
  List<String> names = [];
  late final List<Specialist> specialist;
  List<String> genderList = ['Male', 'Female'];
  String specialistValue = "";
  String degreelistValue = "";


  RxList<String> specialistShowListData = <String>[].obs;

  RxList<String> degreeShowListData = <String>[].obs;


  Rx<ModelSpecialityListResponse> specialistModel = ModelSpecialityListResponse().obs;
  RxBool specialistLoaded = false.obs;


  Rx<ModelDegreeAndConcentrationResponse> degreelistModel = ModelDegreeAndConcentrationResponse().obs;
  RxBool  degreelistLoading = false.obs;

  getSpecialistData(){
    getSpecialityListData().then((value) {
      specialistModel.value = value;
      specialistLoaded.value = true;
      if(value.status == true){
        updateSpecialist();
      }
    });
  }

  updateSpecialist(){
    specialistShowListData.clear();
    if(specialistLoaded.value && isDataLoading.value){
      for(var item in specialistModel.value.data!){
        for(var item1 in model.value.data!.specialist){
          if(item.id.toString() == item1.id.toString()){
            item.selected!.value = true;
            specialistShowListData.add(item.specialistname.capitalize.toString());
          }
        }
      }
    }
  }

  getDegreelistData(){
    getMedicalDegreeConversationListData().then((value) {
      degreelistModel.value = value ;
      degreelistLoading.value = true;
      if(value.status == true){
        updateDegreelist();
      }
    });
  }

  updateDegreelist(){
    degreeShowListData.clear();
    if(degreelistLoading.value && isDataLoading.value){
      for(var item in degreelistModel.value.data!.medicalDegree!){
        for(var item1 in model.value.data!.medicalDegree){
          if(item.id.toString() == item1.id.toString()){
            item.selected!.value = true;
            degreeShowListData.add(item.medicaldegree.toString().capitalize!);
          }
        }
      }
    }
  }


  // File? selectedImage;
  // String? base64Image;

  @override
  void onInit() {
    super.onInit();
    getData(reload: true,specialUpdate: true,degreeUpdate: true);
    getSpecialistData();
    getDegreelistData();
    for (var i = 0; i < 4; i++) {
      names.add("");
    }
  }

  getData({bool reload = false,bool specialUpdate = false,bool degreeUpdate = false}) async {
    String? token = await FirebaseMessaging.instance.getToken();
    isDataLoading.value = false;
    getUserProfileData().then((value) {
      isDataLoading.value = true;
      model.value = value;
      if (value.status == true) {
        if(specialUpdate == true) {
          specialistValue == "";
          for (var item in value.data!.specialist) {
            if (specialistValue == "") {
              specialistValue = item.id.toString();
            } else {
              specialistValue = specialistValue + "," + item.id.toString();
            }
          }
        }
        if(degreeUpdate == true) {
          degreelistValue == "";
          for (var item in value.data!.medicalDegree) {
            if (degreelistValue == "") {
              degreelistValue = item.id.toString();
            } else {
              degreelistValue = degreelistValue + "," + item.id.toString();
            }
          }
        }
        FirebaseFirestore.instance
            .collection("user_collection")
            .doc(value.data!.id.toString())
            .set({
          "user_id": value.data!.id.toString(),
          "user_name": value.data!.name.toString(),
          "user_image": value.data!.profileImage.toString(),
          "token": token,
        });
        if (reload == true) {
          updateSpecialist();
          updateDegreelist();
          nameController.text = model.value.data!.name.toString();
          mobileController.text = model.value.data!.phone.toString();
          emailController.text = model.value.data!.email.toString();
          selectedGender = model.value.data!.gender.toString();
          dobController.text = model.value.data!.dateOfBirth.toString();
          selectedCategory = model.value.data!.categreeId.toString();
          experienceController.text = model.value.data!.experience.toString();
          aboutController.text = model.value.data!.aboutMe.toString();
          specialist= model.value.data!.specialist;
           // selectedImage = model.value.data!.profileImage.toString() as File?;
          for (var i = 0; i < value.data!.documents!.length; i++) {
            names[i] = value.data!.documents![i].toString().split("/").last;
          }
        }
      }
    });
  }
}
