import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/widgets/tok2DocButton.dart';
import 'package:get/get.dart';

class PackageAndPaymentScreen extends StatefulWidget {
  const PackageAndPaymentScreen({Key? key}) : super(key: key);

  @override
  State<PackageAndPaymentScreen> createState() => _PackageAndPaymentScreenState();
}

class _PackageAndPaymentScreenState extends State<PackageAndPaymentScreen> {
  int? upiGroupValue;
  int? netBankingGroupValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xff0E7ECD),
            title: const Text("Package and Payment"),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        blurRadius: 5.0,
                      ),
                    ]

                ),
                child: Column(
                  children: [
                    SizedBox(height: 15.h,),
                    const ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                      leading: Icon(Icons.check_circle,color: AppTheme.primaryColor,),
                      title: Text('Unlimited free consult All doctors 12 months',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500,),),
                      subtitle: Text('Lorem Ipsum is simply dummy rinting and typesetting',style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400,height: 1.5),),
                      trailing: Text('\$200',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppTheme.primaryColor),),
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      children: [
                        SizedBox(width: 52.w,),
                        DottedBorder(
                            color: AppTheme.primaryColor,
                            borderType: BorderType.RRect,
                            padding: EdgeInsets.all(6),
                            radius: Radius.circular(4),
                            child: Text('Flate RS 100 OFF! USe codeXYZ',style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: AppTheme.primaryColor),)),
                        const Spacer(),
                        const Text('-\$10',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppTheme.primaryColor),),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      children: [
                        SizedBox(width: 52.w,),
                        Text('FInal Price',style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: AppTheme.primaryColor),),
                        Spacer(),
                        Text('\$190',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppTheme.primaryColor),),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        blurRadius: 5.0,
                      ),
                    ]

                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 0,
                          activeColor: AppTheme.primaryColor,
                          groupValue: upiGroupValue,
                          onChanged: (value) {
                            setState(() {
                              upiGroupValue = value as int?;
                            });
                          },
                        ),
                        Image.asset(AppAssets.phonePay),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          activeColor: AppTheme.primaryColor,
                          groupValue: upiGroupValue,
                          onChanged: (value) {
                            setState(() {
                              upiGroupValue = value as int?;
                            });
                          },
                        ),
                        Image.asset(AppAssets.googlePay),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          activeColor: AppTheme.primaryColor,
                          groupValue: upiGroupValue,
                          onChanged: (value) {
                            setState(() {
                              upiGroupValue = value as int?;
                            });
                          },
                        ),
                        Image.asset(AppAssets.paytmPay),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        blurRadius: 5.0,
                      ),
                    ]

                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 0,
                          activeColor: AppTheme.primaryColor,
                          groupValue: netBankingGroupValue,
                          onChanged: (value) {
                            setState(() {
                              netBankingGroupValue = value as int?;
                            });
                          },
                        ),
                        Image.asset(AppAssets.sbiNetBanking),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          activeColor: AppTheme.primaryColor,
                          groupValue: netBankingGroupValue,
                          onChanged: (value) {
                            setState(() {
                              netBankingGroupValue = value as int?;
                            });
                          },
                        ),
                        Image.asset(AppAssets.hdfcNetBanking),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          activeColor: AppTheme.primaryColor,
                          groupValue: netBankingGroupValue,
                          onChanged: (value) {
                            setState(() {
                              netBankingGroupValue = value as int?;
                            });
                          },
                        ),
                        Image.asset(AppAssets.iciciNetBanking),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0,),
              Tok2DocButton(AppStrings.payment,
                      () {
                        Get.toNamed(MyRouter.planSuccessFullScreen);
                      }),
              const SizedBox(height: 15.0,),
            ],
          ),
        ),
      ),
    );
  }
}
