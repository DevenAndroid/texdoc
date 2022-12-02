import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
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


class ChatImageFull extends StatefulWidget {
  final String image;
  const ChatImageFull({Key? key,required this.image}) : super(key: key);

  @override
  State<ChatImageFull> createState() => _ChatImageFullState();
}

class _ChatImageFullState extends State<ChatImageFull> {



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

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height:  MediaQuery.of(context).size.height/2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.image,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
                        ),
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
