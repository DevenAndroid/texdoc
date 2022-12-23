import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:texdoc/models/api_models/model_doctor-tips-list_response.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthTipScreen extends StatefulWidget {
 final Data data;
  const HealthTipScreen(this.data, {super.key});

  @override
  State<HealthTipScreen> createState() => _HealthTipScreenState();
}

class _HealthTipScreenState extends State<HealthTipScreen> {
  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: const Text("Health Tip"),
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
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                // Center(
                //   child:
                //   Image.network(
                //     widget.data.imageUrl.toString(),
                //     fit: BoxFit.cover,
                //     height: 200,
                //     width: deviceWidth,
                //   ),
                // )
                Center(
                  child: CachedNetworkImage(
                    height: 200,
                    imageUrl: widget.data.imageUrl.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                    const SizedBox(),
                  ),
                )),
            SizedBox(
              height: 16.h,
            ),
            Text(
              widget.data.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            Text(
              widget.data.createdAt.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                  height: 1.8,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppTheme.greyColor),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              widget.data.description.toString(),
              style: const TextStyle(
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppTheme.greyColor),
            ),
            const SizedBox(height: 18,),
          ],
        ),
      ),
    );
  }
}
