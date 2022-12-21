import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final profileController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: const Text("Chat"),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("firebase_users")
              .doc(profileController.model.value.data!.id.toString())
              .collection("chat_list")
              .snapshots(),
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data!.docs.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.docs[index];
                    var timeStamp1 = item.toString().contains("timeStamp")
                        ? item["timeStamp"].toString()
                        : DateTime.now().toString();
                    var time = DateFormat('hh:mm a').format(
                        DateTime.parse(timeStamp1));
                    var date = DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(timeStamp1));
                    var datetime = "$date, $time";
                    return InkWell(
                      autofocus: true,
                      onTap: () async {
                        Get.to(ChatDetailScreen(
                          otherName: item["sender_name"],
                          otherId: int.parse(item["sender_id"] ?? "0"),
                          sendProfile: item["send_profile"],
                        ));
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
                                const SizedBox(),
                                placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          title: Text(
                            item["sender_name"],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(datetime),
                          subtitle: Text(item["last_message"].toString() == "Basic Information that123qwe147asd33" ?
                          "Shared Problem" : item["last_message"].toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,),
                        ),
                      ),
                    );
                  },
                );
              }
              else {
                return const Center(child: Text("No Patients Available"));
              }
            } else {
              return const Text("No chat Available");
            }
          })),
    );
  }
}
