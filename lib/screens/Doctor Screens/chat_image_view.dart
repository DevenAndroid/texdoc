import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatImageFull extends StatefulWidget {
  final String image;
  const ChatImageFull({Key? key,required this.image}) : super(key: key);

  @override
  State<ChatImageFull> createState() => _ChatImageFullState();
}

class _ChatImageFullState extends State<ChatImageFull> {



  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    var deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: deviceHeight,
            width: deviceWidth,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Container(height: deviceHeight, width: deviceWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),),
                Form(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height:  MediaQuery.of(context).size.height/2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.image,
                            errorWidget: (context, url, error) =>
                                SizedBox(),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
