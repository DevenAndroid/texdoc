import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/app_utils/loading_indicator.dart';
import 'package:texdoc/app_utils/utils.dart';
import 'package:texdoc/controller/get-doctor-tips-list_controller.dart';
import 'package:texdoc/repository/doctor_add_tips_repository.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class CreateHealthTipScreen extends StatefulWidget {
  const CreateHealthTipScreen({Key? key}) : super(key: key);

  @override
  State<CreateHealthTipScreen> createState() => _CreateHealthTipScreenState();
}

class _CreateHealthTipScreenState extends State<CreateHealthTipScreen> {
  DoctorTipsListController allHealthtipsController = Get.put(DoctorTipsListController());
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? selectedImage;
  String? base64Image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: const Text("Create Health Tip"),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 15.h,),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: const Text('Tips Tittle',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
              SizedBox(height: 8.h,),
              TextFormField(
                controller: titleController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Enter Your title',
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
              SizedBox(height: 15.h,),

              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: const Text('Images',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
              SizedBox(height: 8.h,),
              Container(
                height: 55,
                // padding: const EdgeInsets.only(left:12.0,right: 12.0),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                ),
                child: Row(
                  children: [
                  SizedBox(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppTheme.primaryColor,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)), //////// HERE
                    ),
                    onPressed: () async {
                      chooseImage('gallery');
                    },
                    child: const Text("Choose files"),
                  ),
                ),
                    Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(selectedImage==null?"0 Files selected":"1 Files selected",
                          textAlign: TextAlign.center,))
                  ],
                ),
              ),
              SizedBox(height: 15.h,),

              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: const Text('Description',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
              SizedBox(height: 8.h,),
              TextFormField(
                controller: descriptionController,
                obscureText: false,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Enter text here',
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

              SizedBox(height: 40.h,),
              Tok2DocButton(
                  AppStrings.publish,
                      () {
                    showLoadingIndicatorDialog(context);
                    addTips(context, titleController.text, descriptionController.text, "data:image/jpg;base64,$base64Image").then((value) {
                      if(value.status)
                        {
                          Get.back();
                        }
                      allHealthtipsController.getData();
                      return null;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }

//  image choose
  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(source: ImageSource.camera,);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery,);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        print("object::::$base64Image");
      });
    }
  }

}

