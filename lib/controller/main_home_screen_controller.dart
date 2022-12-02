import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../screens/notification_service.dart';

class MainHomeController extends GetxController {
  RxBool chatting = false.obs;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationService notificationService = NotificationService();

  nowChatting() {
    chatting.value = true;
  }

  busy() {
    chatting.value = false;
  }

  @override
  void onInit() {
    super.onInit();

    FirebaseMessaging.onMessage.listen((event) {
      Map<dynamic, dynamic> map = {};
      if (event.data["message"].toString() == "chatMessage") {
        map["message"] = event.data["message"];
        map["otherId"] = event.data["otherId"];
        map["otherName"] = event.data["otherName"];
        map["sendProfile"] = event.data["sendProfile"];
        print("map1111");
        print(map);
        print(event.data["otherId"]);
      }
      notificationService.showNotificationWithPayLoad(
          title: event.notification!.title,
          body: event.notification!.body,
          payload: jsonEncode(map));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Map<dynamic, dynamic> map = {};
      if (event.data["message"].toString() == "chatMessage") {
        map["message"] = event.data["message"];
        map["otherId"] = event.data["otherId"];
        map["otherName"] = event.data["otherName"];
        map["sendProfile"] = event.data["sendProfile"];
        print("map1111");
        print(map);
        print(event.data["otherId"]);
      }
      notificationService.showNotificationWithPayLoad(
          title: event.notification!.title,
          body: event.notification!.body,
          payload: jsonEncode(map));
    });
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      Map<dynamic, dynamic> map = {};
      if (event!.data["message"].toString() == "chatMessage") {
        map["message"] = event.data["message"];
        map["otherId"] = event.data["otherId"];
        map["otherName"] = event.data["otherName"];
        map["sendProfile"] = event.data["sendProfile"];
        print("map1111");
        print(map);
        print(event.data["otherId"]);
      }
      notificationService.showNotificationWithPayLoad(
          title: event.notification!.title,
          body: event.notification!.body,
          payload: jsonEncode(map));
    });
  }
}

// class BottomNavBarController extends GetxController {
//   late AnimationController animationController;
//   late Animation degOneTranslationAnimation,
//       degTwoTranslationAnimation,
//       degThreeTranslationAnimation;
//   late Animation rotationAnimation;
//   RxInt currentIndex = 0.obs;
//   NotificationService notificationService = NotificationService();
//   changeIndex(int value) {
//     currentIndex.value = value;
//     update();
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     FirebaseMessaging.onMessage.listen((event) {
//       notificationService.showNotificationWithPayLoad(
//           title: event.notification!.title,
//           body: event.notification!.body,
//           payload: event.data["message"].toString());
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       if (kDebugMode) {
//         print(event.data["message"]);
//       }
//       if (event.data["message"] == "true") {
//         Get.toNamed(AppRoutes.chatListScreen);
//       }
//     });
//     FirebaseMessaging.instance.getInitialMessage().then((value) {
//       if (value!.data["message"] == "true") {
//         Get.toNamed(AppRoutes.chatListScreen);
//       }
//     });
//   }
// }
