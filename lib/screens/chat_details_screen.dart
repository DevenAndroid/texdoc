import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../app_utils/utils.dart';
import '../controller/get-user-profile_controller.dart';

import '../models/api_models/modal_image_chat.dart';
import '../repository/push_notification.dart';
import '../resources/app_assets.dart';
import 'chatBubble.dart';

class ChatDetailScreen extends StatefulWidget {
  final int otherId;
  final String otherName;
  final String sendProfile;


  const ChatDetailScreen(
      {super.key,
      required this.otherId,
      required this.otherName,
      required this.sendProfile});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {

  Future<ChatImage> sendImage(context, String base64image) async {
    var a = "data:image/jpeg;base64,${base64image}";
    var map = <String, dynamic>{};
    map['image'] = a;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };


    final response = await http.post(Uri.parse("https://tok-2-doc.eoxyslive.com/api/chat-image"),
        body: jsonEncode(map), headers: headers);
    log("chat Map values$map}");
    if (response.statusCode == 200) {
      var bodyData = jsonDecode(response.body);
      //showToast(bodyData['message']);
      imageUrl=bodyData['data']['image_url'].toString();
      sendMessageImage(url: bodyData['data']['image_url'].toString());
      // hide loader
      // Get.back();
      //showToast(response.body);

      // Navigator.pop(context);
      log("loginApiUrl Response${jsonDecode(response.body)}");
      return ChatImage.fromJson(jsonDecode(response.body));

    } 
    else {
      // Get.back();
      // Navigator.pop(context);
      //showToast(response.body);
      var bodyData = jsonDecode(response.body);
      //showToast(bodyData['message']);
      throw Exception("loginApiUrl Error${response.body}");

    }
  }



  final TextEditingController _messageController = TextEditingController();
  final profileController = Get.put(UserProfileController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String chatNode = "";

  String timeDate = "";

  String imageUrl = "";
  /*File? selectedImage;
  String? base64Image;*/
  final int timeStamp = DateTime.now().millisecondsSinceEpoch;
  // File? imageFile;
  File? selectedImage;
  String? base64Image;

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
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // sendImage(context,base64Image!);

        sendImage(context, base64Image!)
            .then((value)  {
          if (value.status==true) {
            // var image = value.data!.imageUrl.toString();
            // var imagea = value.data!.imageUrl.toString();
          } else {
            showToast(value.message);
          }
          return null;
        });
        // print("object$base64Image");
      });
    }
  }

  sendMessage() async {
    final String message = _messageController.text.trim();

    // String? token = await FirebaseMessaging.instance.getToken();
    var timeStamp = FieldValue.serverTimestamp();
    FirebaseFirestore.instance
        .collection("firebase_messaging")
        .doc("messages")
        .collection(chatNode)
        .add({
      "message": message,
      "myId": profileController.model.value.data!.id.toString(),
      "otherId": widget.otherId.toString(),
      "timeStamp": timeStamp
    }).then((value) async {
      _messageController.clear();
      if (kDebugMode) {
        print("sending notification");
      }
      sendNotification(
        msgBody: message,
        msgTitle:
            "New message by ${profileController.model.value.data!.name.toString()}",
        token: token,
        otherId: profileController.model.value.data!.id.toString(),
        otherName: profileController.model.value.data!.name.toString(),
        sendProfile: profileController.model.value.data!.profileImage,
      );
    });

    /// For Me
    FirebaseFirestore.instance
        .collection("firebase_users")
        .doc(profileController.model.value.data!.id.toString())
        .collection("chat_list")
        .doc(widget.otherId.toString())
        .set({
      "sender_id": widget.otherId.toString(),
      "sender_name": widget.otherName.toString(),
      "send_profile": newProfile,
      "last_message": message,
      "timeStamp": timeStamp,
    });

    /// For Other
    FirebaseFirestore.instance
        .collection("firebase_users")
        .doc(widget.otherId.toString())
        .collection("chat_list")
        .doc(profileController.model.value.data!.id.toString())
        .set({
      "sender_id": profileController.model.value.data!.id.toString(),
      "sender_name": profileController.model.value.data!.name.toString(),
      "send_profile": profileController.model.value.data!.profileImage,
      "last_message": message,
      "timeStamp": timeStamp,
    });

    FocusManager.instance.primaryFocus?.unfocus();
  }
  sendMessageImage({
    required url
}) async {
    final String message = _messageController.text.trim();

    // String? token = await FirebaseMessaging.instance.getToken();
    var timeStamp = FieldValue.serverTimestamp();
    print(timeStamp);
    FirebaseFirestore.instance
        .collection("firebase_messaging")
        .doc("messages")
        .collection(chatNode)
        .add({
      "message": "Shared Image from user123123132131",
      "myId": profileController.model.value.data!.id.toString(),
      "otherId": widget.otherId.toString(),
      "image": url,
      "timeStamp": timeStamp

    }).then((value) async {
      print("Image sended");
      print("Image sended");
      print(url);
      _messageController.clear();
      print("sending notification");
      sendNotification(
        msgBody: message,
        msgTitle:
            "New message by ${profileController.model.value.data!.name.toString()}",
        token: token,
        otherId: profileController.model.value.data!.id.toString(),
        otherName: profileController.model.value.data!.name.toString(),
        sendProfile: profileController.model.value.data!.profileImage,
      );
    });

    /// For Me
    FirebaseFirestore.instance
        .collection("firebase_users")
        .doc(profileController.model.value.data!.id.toString())
        .collection("chat_list")
        .doc(widget.otherId.toString())
        .set({
      "sender_id": widget.otherId.toString(),
      "sender_name": widget.otherName.toString(),
      "send_profile": widget.sendProfile,
      "last_message": message,
      //"timeStamp": timeStamp,
    });

    /// For Other
    FirebaseFirestore.instance
        .collection("firebase_users")
        .doc(widget.otherId.toString())
        .collection("chat_list")
        .doc(profileController.model.value.data!.id.toString())
        .set({
      "sender_id": profileController.model.value.data!.id.toString(),
      "sender_name": profileController.model.value.data!.name.toString(),
      "send_profile": profileController.model.value.data!.profileImage,
      "last_message": message,
      "timeStamp": timeStamp,
    });

    FocusManager.instance.primaryFocus?.unfocus();
  }

  createChatNode() {
    if (profileController.model.value.data!.id > widget.otherId) {
      chatNode = "${profileController.model.value.data!.id}${widget.otherId}";
    } else {
      chatNode = "${widget.otherId}${profileController.model.value.data!.id}";
    }
  }

  String token = "";
  String newName = "";
  String newProfile = "";

  @override
  void initState() {
    super.initState();
    createChatNode();
    FirebaseFirestore.instance
        .collection("user_collection")
        .doc(widget.otherId.toString())
        .get()
        .then((value) {
      token = value.data()!["token"] ?? "";
      newName = value.data()!["user_name"] ?? "";
      newProfile = value.data()!["user_image"] ?? "";
      print(token);
      print(newName);
      print(newProfile);
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: Text(widget.otherName.toString()),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("firebase_messaging")
                    .doc("messages")
                    .collection(chatNode)
                    .orderBy("timeStamp", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {

                    return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data!.docs[index];
                        if(item["timeStamp"] !=null)
                          {
                            var timeStamp1 = (item["timeStamp"]).toDate();
                            timeDate = DateFormat('hh:mm a').format(timeStamp1);
                          }
                        else
                          {

                            timeDate = "";
                          }


                        if(item.toString().contains('image')){
                          print("Sended Images... ");
                        }
                        print(item.toString());
                        return ChatBubble(
                            firstMessage: item["message"].toString() == "Basic Information that123qwe147asd33" ? item["message"].toString() : "",
                            age: item["message"].toString() == "Basic Information that123qwe147asd33" ? item["initialMessage"]["age"] : "",
                            gender: item["message"].toString() == "Basic Information that123qwe147asd33" ? item["initialMessage"]["gender"] : "",
                            problemText: item["message"].toString() == "Basic Information that123qwe147asd33" ?
                            item["initialMessage"].toString().contains("problem") ? item["initialMessage"]["problem"] : ""  : "",
                            name: newName,
                            text: item["message"],
                            sendImage: item["message"].toString() == "Shared Image from user123123132131" ? item["image"] : "",
                            image: widget.sendProfile,
                            image1: profileController.model.value.data!.profileImage,
                            date_time: timeDate,
                            //imageOther:"data:image/jpg;base64,${base64Image}",
                            isCurrentUser: item["myId"].toString() ==
                                profileController.model.value.data!.id
                                    .toString()
                                ? true
                                : false);
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: const Color(0xffEEEFFC),
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                SizedBox(
                  width: 10.h,
                ),
                InkWell(
                    onTap: () {
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
                                    chooseImage('Gallery');
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
                    child: const Icon(Icons.attach_file_outlined)),
                SizedBox(
                  width: 10.h,
                ),
                /*const Icon(Icons.emoji_emotions_outlined),
                SizedBox(width: 12.h,),*/
                Flexible(
                  child: TextFormField(
                    controller: _messageController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: 'Write a message...',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.h,
                ),
                GestureDetector(
                    onTap: () {
                      if (_messageController.text.isNotEmpty) {
                        sendMessage();
                      }
                    },
                    child: Image.asset(AppAssets.sendMessage)),
                SizedBox(
                  width: 12.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
