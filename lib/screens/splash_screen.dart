import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/routers/my_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();

      // FirebaseAuth _auth = FirebaseAuth.instance;
      if (pref.getString('user') != null && pref.getBool("document_verified") == true) {
        Get.offNamed(MyRouter.bottomNavBarCustom);
      } else if (pref.getBool("document_verified") != true) {
        Get.offNamed(MyRouter.loginScreen);
      } else {
        Get.offAllNamed(MyRouter.onBoardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: deviceWidth * 1,
              height: deviceHeight * 1,
              child: Image.asset(
                AppAssets.splashBg,
                fit: BoxFit.fill,
              )),
          Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Image.asset(
                AppAssets.splashLogo,
                height: 200,
                width: 200,
              ))
        ],
      ),
    );
  }
}
