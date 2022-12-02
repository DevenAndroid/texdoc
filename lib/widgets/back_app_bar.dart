
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/routers/my_router.dart';

class CustomBackAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  const CustomBackAppBar({
    Key? key, required this.title,
  }) : super(key: key);

  @override
  State<CustomBackAppBar> createState() => _CustomBackAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(78);
}

class _CustomBackAppBarState extends State<CustomBackAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'location',
              style:  TextStyle(
                color: AppTheme.greyColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on,color: AppTheme.greyColor,),
                const SizedBox(width: 4.0,),
                Text(
                  "Pila, Poland",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
              onTap: (){
                Get.toNamed(MyRouter.notificationScreen);
              },
              child: const Icon(Icons.notifications_none_outlined,color: AppTheme.greyColor,)),
          const SizedBox(width: 12,),
          Container(
            margin: const EdgeInsets.only(top: 10,bottom: 10),
            width: MediaQuery.of(context).size.width*0.10,
            decoration:  const BoxDecoration(
              color: AppTheme.greyColor,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(10),
              child: Image.asset(AppAssets.manImage,fit: BoxFit.cover,),
            ),
          ),
          const SizedBox(width: 16,)
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}