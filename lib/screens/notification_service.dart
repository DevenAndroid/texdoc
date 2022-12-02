import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../controller/main_home_screen_controller.dart';
import '../screens/chat_details_screen.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings darwinInitializationSettings =
      const DarwinInitializationSettings(
          requestAlertPermission: true,
          requestSoundPermission: true,
          defaultPresentSound: true,
          defaultPresentAlert: true,
          defaultPresentBadge: true);
  AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails("Doctor", "Doctors",
          priority: Priority.max, importance: Importance.max);
  DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails(
    presentSound: true,
  );
  initializeNotification() async {
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);
    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          log(response.payload.toString());
          Map<dynamic, dynamic> map = jsonDecode(response.payload.toString());
          if (map["message"] == "chatMessage") {
            final mainController = Get.put(MainHomeController());
            if (mainController.chatting.value == false) {
              Get.to(ChatDetailScreen(
                // {message: chatMessage, otherId: 1043, otherName: abhi,
                // sendProfile: https://tok-2-doc.eoxyslive.com/profile-image/637e006e665b5_1043user_image.jpg}
                otherName: map["otherName"],
                otherId: int.parse(map["otherId"] ?? "0"),
                sendProfile: map["sendProfile"],
              ));
            }
          }
        }
      },
    );
  }

  showSimpleNotification({
    required title,
    required body,
  }) {
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    localNotificationsPlugin.show(0, title, body, notificationDetails);
  }

  showNotificationWithPayLoad({
    required title,
    required body,
    required payload,
  }) {
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    localNotificationsPlugin.show(2, title, body, notificationDetails,
        payload: payload);
  }

  listenToNotification() {}
}
