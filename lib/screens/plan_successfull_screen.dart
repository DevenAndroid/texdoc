import 'package:flutter/material.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PlanSuccessFullScreen extends StatefulWidget {
  const PlanSuccessFullScreen({Key? key}) : super(key: key);

  @override
  State<PlanSuccessFullScreen> createState() => _PlanSuccessFullScreenState();
}

class _PlanSuccessFullScreenState extends State<PlanSuccessFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(AppAssets.planSuccess),
            SizedBox(height: 40.h,),
            const Text(AppStrings.planSuccessfull,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
            SizedBox(height: 16.h,),
            const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,height: 1.8),),
            const Spacer(),
            Tok2DocButton(AppStrings.startConsultation, () {
              Get.offAllNamed(MyRouter.bottomNavBarCustom);
            })
          ],
        ),
      ),
    );
  }
}
