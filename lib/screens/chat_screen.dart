import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/get-user-profile_controller.dart';
import 'chat_details_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final profileController = Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    // getMyId();
  }

  int myId = 0;

  // getMyId() async {
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     myId = value.data()!["time_stamp"];
  //     print("::::::$myId");
  //   });
  // }

  // String chatRoomId(String user1, String user2) {
  //   if (user1[0].toLowerCase().codeUnits[0] >
  //       user2[0].toLowerCase().codeUnits[0]) {
  //     return "$user1$user2";
  //   } else {
  //     return "$user2$user1";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: Text("Chat"),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )),
      body: StreamBuilder(
          // stream: FirebaseFirestore.instance.collection("messages").where("user_id", isEqualTo: firebaseAuth.currentUser!.uid.toString()).snapshots(),
          stream: FirebaseFirestore.instance
              .collection("firebase_users")
              .doc(profileController.model.value.data!.id.toString())
              .collection("chat_list")
              .snapshots(),
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data!.docs[index];
                  var timeStamp1 = item.toString().contains("timeStamp") ? item["timeStamp"].toString() : DateTime.now().toString();
                  var time = DateFormat('hh:mm a').format(DateTime.parse(timeStamp1));
                  var date = DateFormat('dd/MM/yyyy').format(DateTime.parse(timeStamp1));
                  var datetime=date+", "+time;



                  print("AAAAAA${item["send_profile"]}");
                  return InkWell(
                    autofocus: true,
                    onTap: () async {
                      Get.to(ChatDetailScreen(
                        otherName: item["sender_name"],
                        otherId: int.parse(item["sender_id"] ?? "0"),
                        sendProfile: item["send_profile"],
                      ));
                      await firebaseAuth.currentUser!.reload();
                      print("AAAAAA${item["send_profile"]}");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(4),
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: item["send_profile"],
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        title: Text(
                          item["sender_name"],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(datetime),
                        subtitle: Text(item["last_message"]),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text("No chat Aveliable");
            }
            return Center(child: CircularProgressIndicator());
          })),
    );
  }
}
