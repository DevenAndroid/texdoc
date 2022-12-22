import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../resources/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
    required this.image,
    required this.image1,
    this.sendImage,
    required this.date_time,
    this.age,
    this.gender,
    this.name,
    this.firstMessage = "", this.problemText, this.country = "", this.dob = "", this.weight= "",
  }) : super(key: key);
  final String text;
  final String image;
  final String image1;
  final bool isCurrentUser;
  final String? sendImage;
  final String date_time;
  final String? firstMessage;
  final String? age;
  final String? name;
  final String? problemText;
  final String? gender;
  final String? country;
  final String? dob;
  final String? weight;

  // "age" (Done)
  // "gender" (Done)
  // "problem" (Done)
  // "country" (Done)
  // "dob" (Done)
  // "weight" (Done)

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  DateFormat formatter = DateFormat('dd-MMM-yyyy');

  Future<void> _launchUrl(value) async {
    final Uri url = Uri.parse(value);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw Exception(e);
    }
  }

  showDialogue({
    required imageUrl
  }){
    showDialog(context: context, builder: (context){
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 12),
        backgroundColor: Colors.transparent,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    _launchUrl(imageUrl);
                  }, child: const Text("Save")),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      ))
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width*.8,
                child: InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    errorWidget: (_,__,___)=> const SizedBox(),
                    placeholder: (_,__)=> const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return widget.firstMessage == "" ?
    Padding(
        padding: EdgeInsets.fromLTRB(
          widget.isCurrentUser ? 64.0 : 16.0, 15,
          widget.isCurrentUser ? 16.0 : 64.0, 4,
        ),
        child: widget.isCurrentUser == true ?
        Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.text.toString() != "Shared Image from user123123132131" ?
                    Flexible(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.isCurrentUser ? AppTheme.primaryColor : Colors.grey[300],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              widget.text,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: widget.isCurrentUser ? Colors.white : Colors.black87),
                            )),
                      ),
                    ) :
                    Row(
                      children: [
                        GestureDetector(onTap: (){

                          showDialogue(imageUrl: widget.sendImage!);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ChatImageFull(image:widget.sendImage.toString(),),
                          //     ));
                        },child: Container(
                          width: 120,
                          height:120,
                          child: CachedNetworkImage(
                            imageUrl: widget.sendImage!,
                            fit: BoxFit.contain,
                            errorWidget: (_,__,___)=> const SizedBox(),
                            placeholder: (_,__)=> const SizedBox(),
                          ),
                        ),),

                      ],
                    ),
                    const SizedBox(width: 8,),
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.image1,
                          errorWidget: (_,__,___)=> const SizedBox(),
                          placeholder: (_,__)=> const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          widget.date_time.toString(),
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: widget.isCurrentUser ? Colors.black : Colors.black87),
                        )),
                  ],
                )


              ],
            ))
            : Align(
            alignment: Alignment.topRight,
            child:  Column(
              children: [
                Row(
                  children: [

                    SizedBox(
                      width: 35,
                      height: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.image,
                          errorWidget: (_,__,___)=> const SizedBox(),
                          placeholder: (_,__)=> const SizedBox(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    widget.text.toString() != "Shared Image from user123123132131" ?
                    Flexible(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.isCurrentUser ? AppTheme.primaryColor : Colors.grey[300],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              widget.text,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: widget.isCurrentUser ? Colors.white : Colors.black87),
                            )),
                      ),
                    ) :
                    Row(
                      children: [
                        GestureDetector(onTap: (){
                          showDialogue(imageUrl: widget.sendImage!);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ChatImageFull(image:widget.sendImage.toString(),),
                          //     ));
                        },child: SizedBox(
                          width: 120,
                          height:120,
                          child: CachedNetworkImage(
                            imageUrl: widget.sendImage!,
                            fit: BoxFit.contain,
                            errorWidget: (_,__,___)=> const SizedBox(),
                            placeholder: (_,__)=> const SizedBox(),
                          ),
                        ),)

                      ],
                    ),


                  ],
                ),
                Row(
                  children: [

                    Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          widget.date_time.toString(),
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: widget.isCurrentUser ? Colors.black : Colors.black87),
                        )),
                  ],
                )
              ],
            ))
    ) :
    Row(
      mainAxisAlignment: widget.isCurrentUser == true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: widget.isCurrentUser == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 4),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Basic Information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              fontSize: 18,
                              color: AppTheme.primaryColor
                          ),),

                        ///Name : FULL NAME
                        // Age :
                        // Gender :
                        // Country :
                        // Date of Birth :
                        // Weight :
                        // Prescription / Problem description

                        /// Name
                        RichText(
                          text: TextSpan(
                            text: 'Name : ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.25,
                                fontSize: 15,
                                color: Colors.black
                            ),
                            children: <TextSpan>[
                              TextSpan(text: widget.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        /// Age
                        if(widget.age != "0" && widget.age != "")
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: RichText(
                              text: TextSpan(
                                text: 'Age : ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.25,
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: widget.age, style: const TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        /// Gender
                        RichText(
                          text: TextSpan(
                            text: 'Gender : ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.25,
                                fontSize: 15,
                                color: Colors.black
                            ),
                            children: <TextSpan>[
                              TextSpan(text: widget.gender, style: const TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        /// Country
                        if(widget.country != "0" && widget.country != "")
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: RichText(
                              text: TextSpan(
                                text: 'Country : ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.25,
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: widget.country, style: const TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        /// DOB
                        if(widget.dob != "0" && widget.dob != "")
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: RichText(
                              text: TextSpan(
                                text: 'Date of Birth : ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.25,
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: formatter.format(DateTime.parse(widget.dob.toString())), style: const TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        /// Weight
                        if(widget.weight != "0" && widget.weight != "")
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: RichText(
                              text: TextSpan(
                                text: 'Weight : ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.25,
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: widget.weight, style: const TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        /// Problem
                        RichText(
                          text: TextSpan(
                            text: 'Prescription / Problem description : ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.25,
                                fontSize: 15,
                                color: Colors.black
                            ),
                            children: <TextSpan>[
                              TextSpan(text: widget.problemText, style: const TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: widget.isCurrentUser == true ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
                    child: Text(
                      widget.date_time.toString(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: widget.isCurrentUser ? Colors.black : Colors.black87),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
