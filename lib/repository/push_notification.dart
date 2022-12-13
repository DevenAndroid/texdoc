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
        'key=AAAAwrm-Adk:APA91bG9bcMdaQfqUbUezz_4HW0EducU2Al_wHBPiockz00BGwvdieqrEEVYRbbMvSDlpApLvUNBbieszqmNyqUHuBonElGedqrJ5OzCl6FNkxDHOB2cuPYy0MsAT2gRE36Zsr9140L7'
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
