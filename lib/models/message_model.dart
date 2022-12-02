import 'package:texdoc/resources/app_assets.dart';

class MessageModelResponse{
  final String? messageTitle , messageSubTitle, messageTime;
  final String? image;

  MessageModelResponse({this.messageTitle,this.messageSubTitle,this.messageTime, this.image,});
}

List<MessageModelResponse> MessageData = [

  MessageModelResponse(
      messageTitle: "Lukas Frost",
      image: AppAssets.doctorA,
    messageSubTitle: "Hello, How are you?",
    messageTime: "12.00 Am"
  ),
  MessageModelResponse(
      messageTitle: "Carlos Evans",
    image: AppAssets.doctorB,
    messageSubTitle: "Hey! How have you been?",
      messageTime: "12.35 Am"
  ),
  MessageModelResponse(
      messageTitle: "Joel Morris",
    image: AppAssets.doctorC,
      messageSubTitle: "I'm good! Just got back",
      messageTime: "12.45 Am"
  ),
  MessageModelResponse(
      messageTitle: "Sebastian Wiggins",
    image: AppAssets.doctorD,
      messageSubTitle: " What do you say?",
      messageTime: "12.00 Am"
  ),
  MessageModelResponse(
      messageTitle: "Jayda Frye",
    image: AppAssets.doctorE,
      messageSubTitle: "eleven things you should avoid",
      messageTime: "12.20 Pm"
  ),
  MessageModelResponse(
      messageTitle: "Mark Freeman",
    image: AppAssets.doctorF,
      messageSubTitle: "handle a text message",
      messageTime: "11.35 Am"
  ),
  MessageModelResponse(
      messageTitle: "Sullivan Shepherd",
    image: AppAssets.doctorG,
      messageSubTitle: "What do you do? ",
      messageTime: "11.35 Pm"
  ),
  MessageModelResponse(
      messageTitle: "Larissa Pena",
      image: AppAssets.doctorH,
      messageSubTitle: "sender with as little pain",
      messageTime: "11.35 Pm"
  ),
];
