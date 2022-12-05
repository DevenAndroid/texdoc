import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/api_models/modal_image_chat.dart';
import '../resources/app_theme.dart';
import 'Doctor Screens/chat_image_view.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
    required this.image,
    required this.image1,
    this.sendImage,
    required this.date_time,


  }) : super(key: key);
  final String text;
  final String image;
  final String image1;
  final String date_time;
  final bool isCurrentUser;
  String? sendImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
          isCurrentUser ? 64.0 : 16.0, 15,
          isCurrentUser ? 16.0 : 64.0, 4,
        ),
        child:  isCurrentUser == true ?
        Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        text.toString() != "Shared Image from user123123132131" ?
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: isCurrentUser ? AppTheme.primaryColor : Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                text,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: isCurrentUser ? Colors.white : Colors.black87),
                              )),
                        ) :
                        Row(
                          children: [
                            GestureDetector(onTap: ()
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatImageFull(image:sendImage.toString(),),
                                  ));
                              /*MaterialPageRoute(
                              builder: (context) => ChatImage(sendImage!,)),
                            );*/
                            },child: Container(
                              width: 120,
                              height:120,
                              child: CachedNetworkImage(
                                imageUrl: sendImage!,
                                fit: BoxFit.contain,
                                errorWidget: (_,__,___)=> SizedBox(),
                                placeholder: (_,__)=> SizedBox(),
                              ),
                            ),)


                          ],
                        ),
                        SizedBox(width: 8,),
                        SizedBox(
                          width: 35,
                          height: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: image1,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                            ),
                          ),
                        ),



                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                            padding: const EdgeInsets.only(left: 4,top: 4),
                            child: Text(
                              date_time.toString(),
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: isCurrentUser ? Colors.black : Colors.grey, fontSize: 12.0,),
                            )),
                      ],
                    )

                  ],
                ),


              ],
            ))
            : Align(
            alignment: Alignment.topRight,
            child:  Column(children: [

              Row(
                children: [

                  SizedBox(
                    width: 35,
                    height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: image,
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
                  text.toString() != "Shared Image from user123123132131" ?
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: isCurrentUser ? AppTheme.primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          text,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: isCurrentUser ? Colors.white : Colors.black87),
                        )),
                  ) :
                  Row(
                    children: [
                      GestureDetector(onTap: ()
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatImageFull(image:sendImage.toString(),),
                            ));
                        /*MaterialPageRoute(
                              builder: (context) => ChatImage(sendImage!,)),
                            );*/
                      },child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        width: 120,
                        height:120,
                        child: CachedNetworkImage(

                          imageUrl: sendImage!,
                          fit: BoxFit.contain,
                          errorWidget: (_,__,___)=> SizedBox(),
                          placeholder: (_,__)=> SizedBox(),
                        ),
                      ),)
                      /* Container(
                      width: 120,
                      height:120,
                      child: CachedNetworkImage(
                        imageUrl: sendImage!,
                        fit: BoxFit.contain,
                        errorWidget: (_,__,___)=> SizedBox(),
                        placeholder: (_,__)=> SizedBox(),
                      ),
                    ),*/
                    ],
                  ),


                ],
              ),
              Row(
                children: [

                  Padding(
                      padding: const EdgeInsets.only(left: 4,top: 4),
                      child: Text(
                        date_time.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: isCurrentUser ? Colors.black : Colors.grey, fontSize: 12.0,),
                      )),
                ],
              )

            ],))
    );
  }
}
