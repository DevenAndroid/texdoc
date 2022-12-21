
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:texdoc/models/onboardData_model.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/routers/my_router.dart';

class OnBoardongScreen extends StatefulWidget {
  const OnBoardongScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardongScreen> createState() => _OnBoardongScreenState();
}

class _OnBoardongScreenState extends State<OnBoardongScreen> {

  late PageController _pageController;
  final RxInt _pageIndex = 0.obs;
  RxDouble page1 = (1.0).obs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      page1.value = _pageController.page!+1;
    });

  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12.0),
          child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      itemCount: OnBoardData.length,
                      controller: _pageController,
                      onPageChanged: (index) {
                        _pageIndex.value = index;
                        print("::::" + _pageIndex.toString());
                      },
                      itemBuilder: (context, index) {
                        return OnboardContent(
                          image: OnBoardData[index].image.toString(),
                          title: OnBoardData[index].title.toString(),
                          description: OnBoardData[index].description.toString(),
                        );
                      }),
                ),
                Obx(() {
                  return Row(
                    children: [
                      ...List.generate(OnBoardData.length, (index) =>
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: CustomIndiactor(
                              isActive: index == _pageIndex.value,),
                          )),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                          if (_pageIndex.value == 2) {
                            Get.offAllNamed(MyRouter.loginScreen);
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.transparent
                          ),
                          width: 64,
                          height: 64,
                          child: Obx(() {
                            return Stack(
                              children: [
                                Positioned.fill(
                                  child: Transform(
                                    transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      value: page1.value / 3,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue.shade600
                                    ),
                                    width: 55,
                                    height: 55,
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 20,),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      )
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      );

  }
}

class CustomIndiactor extends StatelessWidget {
  final bool isActive;

  CustomIndiactor({
    Key? key, this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 24 : 16,
      height: 4,
      decoration: BoxDecoration(
          color:isActive? AppTheme.primaryColor:AppTheme.primaryColor.withOpacity(0.2) ,
          borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  final String image, title, description;

  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Align(
            alignment: Alignment.center,
            child: Image.asset(image, height: 250,)),
        const Spacer(),
        Text(title,
          // textAlign: TextAlign.center,
          style: Theme
              .of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w600),),
        SizedBox(height: 12.h,),
        Text(description,
          // textAlign: TextAlign.center,
          style: const TextStyle(height: 1.5, color: Color(0xff9C9CB4)),),
        const Spacer(),
      ],
    );
  }
}
