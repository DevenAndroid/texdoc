import 'package:flutter/material.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:get/get.dart';
import 'package:texdoc/screens/Doctor%20Screens/bottom_navbar_custom.dart';

PreferredSize customAppBar(GlobalKey<ScaffoldState> scaffoldkey,onTap) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(78.0), // here the desired height
      child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppBar(
            elevation: 0,
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    scaffoldkey.currentState!.openDrawer();
                  },
                  icon: Image.asset(AppAssets.drawerIcon));
            }),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'location',
                  style: TextStyle(
                    color: AppTheme.greyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppTheme.greyColor,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
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
                  onTap: () {
                    Get.toNamed(MyRouter.notificationScreen);
                  },
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    color: AppTheme.greyColor,
                  )),
              const SizedBox(
                width: 14,
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  // width: MediaQuery.of(context).size.width*0.10,
                  decoration: const BoxDecoration(
                    color: AppTheme.greyColor,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppAssets.manImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              )
            ],
            centerTitle: true,
            backgroundColor: Colors.white,
          )));
}
