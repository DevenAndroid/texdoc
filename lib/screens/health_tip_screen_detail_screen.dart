import 'package:flutter/material.dart';
import 'package:texdoc/models/api_models/model_doctor-tips-list_response.dart';
import 'package:texdoc/models/message_model.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthTipScreen extends StatefulWidget {
  Data data;
  HealthTipScreen(this.data);

  @override
  State<HealthTipScreen> createState() => _HealthTipScreenState();
}

class _HealthTipScreenState extends State<HealthTipScreen> {
  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: Text("Health Tip"),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.data.title.toString(),style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
            Text(widget.data.createdAt.toString(),textAlign: TextAlign.left,style: const TextStyle(height: 1.8,fontWeight: FontWeight.w500, fontSize: 12, color: AppTheme.greyColor),),
            SizedBox(height: 24.h,),
            ClipRRect(
              borderRadius:
              BorderRadius.circular(10),
              child: Center(
                child: Image.network(widget.data.imageUrl.toString(),
                  fit: BoxFit.cover,
                  height: 200,width: deviceWidth,),
              ),
            ),
            SizedBox(height: 18.h,),
            Text(widget.data.description.toString(),style: TextStyle(height:1.5,fontWeight: FontWeight.w500, fontSize: 14,  color: AppTheme.greyColor),
            )

          ],
        ),
      ),
    );
  }
}
