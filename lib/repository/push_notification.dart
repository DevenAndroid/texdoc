import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<dynamic> sendNotification({
  msgTitle,
  msgBody,
  token,
  otherId,
  otherName,
  sendProfile,
}) async {
  if (kDebugMode) {
    print('token : $token');
  }

  // final int otherId;
  // final String otherName;
  // final String sendProfile;

  final data = {
    "notification": {
      "body": "$msgBody",
      "title": "$msgTitle",
    },
    "android": {"priority": "high"},
    "priority": 10,
    "data": {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "message": "chatMessage",
      "otherId": otherId,
      "otherName": otherName,
      "sendProfile": sendProfile,
    },
    "to": "$token"
  };
  final headers = {
    'content-type': 'application/json',
    'Authorization':
        'key=AAAAyuLp4aI:APA91bEj0M6LyIa5PkQIalTZC_YtyADUP-yE85fRBKF1ukKXrrJxYEWr3yioyI9kMJkPnP0UpKK5mM1MJxeZZbtH4w8u9ZSSTFapKyIF85xpKcUHrUOE97ECnDmpABj_xrNHEGTnk9ky'
  };
  try {
    final response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        body: jsonEncode(data),
        headers: headers);
    if (kDebugMode) {
      print(response.body);
    }
  } catch (e) {
    throw Exception(e);
  }
}
