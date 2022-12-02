import 'package:flutter/material.dart';
import 'package:texdoc/models/message_model.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/screens/health_tip_screen_detail_screen.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: Container(
            // padding: EdgeInsets.all(8),
            child: AppBar(
              backgroundColor: Color(0xff0E7ECD),
              title: const Text("Notification"),
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              // ...
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20),
          child: Column(
            children: [
              // ignore: prefer_const_constructors
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Notification',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
              SizedBox(height: 15.h,),
              ListView.builder(
                physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: MessageData.length,
                  itemBuilder: (BuildContext context,index){
                    return uiMessageList(MessageData[index]);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget uiMessageList(MessageModelResponse messageData) {
    return  Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        onTap: (){
          // Get.to(HealthTipScreen(messageData));
        },
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
          backgroundImage: AssetImage(messageData.image.toString()),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(messageData.messageTime.toString(),style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500, color: AppTheme.greyColor),),
            Text(messageData.messageTitle.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,height: 1.5),),
          ],
        ),
        subtitle: Text(messageData.messageSubTitle.toString(),style: const TextStyle(height: 1.5),),
        // trailing:  Text(messageData.messageTime.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
      ),
    );
  }
}
