import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texdoc/controller/get-doctor-tips-list_controller.dart';
import 'package:texdoc/models/api_models/model_doctor-tips-list_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:texdoc/resources/strings.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/screens/health_tip_screen_detail_screen.dart';
import 'package:flutter_svg/svg.dart';

class AllHealthTipScreen extends StatefulWidget {
  const AllHealthTipScreen({Key? key}) : super(key: key);

  @override
  State<AllHealthTipScreen> createState() => _AllHealthTipScreenState();
}

class _AllHealthTipScreenState extends State<AllHealthTipScreen> {
  final _formKey = GlobalKey<FormState>();

  DoctorTipsListController controller = Get.put(DoctorTipsListController());
  TextEditingController instituteController = TextEditingController();

  String? selectedDegree;
  String? selectedMajorGroup;


  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5),
            child: Column(
              children: [
                SizedBox(height: 15.h,),
                Row(
                  children: [
                    const Text('All Health Tips', style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(MyRouter.createHealthTipScreen);
                      },
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: AppTheme.greyColor.withOpacity(0.2),
                        child: const Icon(Icons.add, size: 20,
                          color: AppTheme.primaryColor,),),
                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                !controller.isDataLoading.value ?
                const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor,)): controller.model.value.data!.isEmpty
                    ? Center(
                      child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.noTips,
                            height: MediaQuery.of(context).size.height*0.20,
                            // width: 80.0,
                            allowDrawingOutsideViewBox: true,),
                          const SizedBox(height: 16,),
                          const Text('No tips Found'),
                        ],
                      ),
                  ),
                ),
                    ): ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.model.value.data!.length,
                    itemBuilder: (BuildContext context, index) {
                      return uiMessageList(controller.model.value.data![index]);
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget uiMessageList(Data data) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16.0,),
      child: ListTile(
        onTap: () {
          Get.to(HealthTipScreen(data));
        },
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
          // backgroundImage: AssetImage(data.image.toString()),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: CachedNetworkImage(
              imageUrl: data.imageUrl.toString(),
              imageBuilder:
                  (context, imageProvider) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      ),
                    ),
                  ),
              placeholder: (context, url) =>
              const Center(
                  child:
                  CircularProgressIndicator()),
              errorWidget:
                  (context, url, error) =>
              const Icon(Icons.error),
            ),
          ),
        ),
        title: Text(data.title.toString(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
        subtitle: Text(data.createdAt.toString(),
          style: const TextStyle(height: 2.0),),
        // trailing:  Text(messageData.messageTime.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
      ),
    );
  }
}
