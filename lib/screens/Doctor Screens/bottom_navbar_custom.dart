import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texdoc/controller/get-user-profile_controller.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:texdoc/routers/my_router.dart';
import 'package:texdoc/screens/chat_screen.dart';
import 'package:texdoc/screens/dr_profile_screen.dart';
import 'package:texdoc/screens/my_profile_screen.dart';
import '../../controller/main_home_screen_controller.dart';
import 'all_health_tip_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomNavBarCustom extends StatefulWidget {
  int? drawerNavigateIndex;
   BottomNavBarCustom(this.drawerNavigateIndex,{Key? key,}) : super(key: key);

  @override
  State<BottomNavBarCustom> createState() => _BottomNavBarCustomState();
}

class _BottomNavBarCustomState extends State<BottomNavBarCustom> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  UserProfileController controller = Get.put(UserProfileController());
  final controller1 = Get.put(MainHomeController());
  RxString userImage = "".obs;
  RxString userName = "".obs;
  RxString userSpecility = "".obs;


  int pageIndex = 3;
  int? selectedDrawerIndex;
  final pages = [
    const AllHealthTipScreen(),
    // const ChatScreen(),
    const DrProfileScreen(),
    const MyProfileScreen(),
  ];

  // List drawerItem =
  // [
  //   "Dashboard",
  //   "Health Tips",
  //   "Set Time",
  //   "My Profile",
  //   "Log Out",
  // ];

  List<ListItem> drawerItem = [
    ListItem(title: 'Dashboard', image: AppAssets.drawerDeshbrd),
    ListItem(title: 'Health Tips', image: AppAssets.drawerHealthTips),
    ListItem(title: 'Chat', image: AppAssets.drawerChat),
    ListItem(title: 'Set Time', image: AppAssets.drawerSetTime),
    ListItem(title: 'My Profile', image: AppAssets.drawerMyProfile),
    ListItem(title: 'Log Out', image: AppAssets.drawerLogout),
  ];


  @override
  void initState() {
    super.initState();
    controller.getData();

    setState((){
      pageIndex=widget.drawerNavigateIndex!;
      print("init method");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(controller.isDataLoading.value){
      userImage = controller.model.value.data!.profileImage.obs;
      userName = controller.model.value.data!.name.obs;
      userSpecility = controller.model.value.data!.email.obs;
      print("object userImage$userImage");
      print("object userName$userName");
      print("object userSpecility$userSpecility");
    }

    return Scaffold(
      key: _scaffoldkey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78.0), // here the desired height
          child: AppBar(
            // automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff0E7ECD),
            // leading: const Icon(null),
            title: Text(
              pageIndex == 0
                  ? "All Health Tip" : pageIndex ==1
                  ? "" : "My Profile"
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            // ...
          )),
      body: pages[pageIndex],
      drawer: pageIndex == 1 ? SizedBox(
        width: MediaQuery.of(context).size.width*0.7,
        child: Drawer(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 12.0),
                  leading: CircleAvatar(
                    radius: 30,
                    // backgroundImage: AssetImage(AppAssets.doctorF),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100000),
                      child: userImage!= "" ? Image.network(userImage.toString(), fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ) : Image.asset(AppAssets.splashLogo,fit: BoxFit.cover,)),
                  ),
                  title: Text(userName.toString()),
                  subtitle: Text(userSpecility.toString()),
                ),
                SizedBox(
                  height: double.maxFinite,
                  child: ListView.builder(
                      itemCount: drawerItem.length,
                      itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        setState((){
                          selectedDrawerIndex = index;
                          switch (index){
                              case 0:
                              Get.back();
                              setState((){
                                pageIndex=1;
                              });
                              break;
                              case 1:
                              Get.back();
                              setState((){
                                pageIndex=0;
                              });
                              break;
                              case 2:
                              Get.back();
                              Get.toNamed(MyRouter.chatScreen);
                              break;
                            case 3:
                              Get.back();
                              Get.toNamed(MyRouter.setTimeScreen);
                              break;
                              case 4:
                              Get.back();
                              setState((){
                                pageIndex=2;
                              });
                              break;
                            case 5:
                              // logout from app
                              getLogout();
                                // logout from firebase
                                try {
                                  print("Working logout");
                                  FirebaseAuth.instance.signOut().then((value) {
                                    Get.toNamed(MyRouter.loginScreen);
                                  }).catchError((e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text(e.toString())));
                                  });
                                } on FirebaseException catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(e.toString())));
                                  throw Exception(e);
                                } catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(e.toString())));
                                  throw Exception(e);
                                }

                              break;
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 12,bottom: 12,right: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: selectedDrawerIndex==index?AppTheme.primaryColor :null,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          children: [
                            Image.asset(drawerItem[index].image.toString()),
                            SizedBox(width: 14.h,),
                            Text(drawerItem[index].title.toString(),style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: selectedDrawerIndex == index
                                  ? Colors.white
                                  : null,),)
                          ],
                        ),
                      ),
                    );}),
                )
              ],
            ),
          ),
        ),
      ) : null,
      floatingActionButton:FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // child: SvgPicture.asset(AppAssets.homeIcon,height: deviceHeight,width: deviceWidth,),
        child: Image.asset(AppAssets.homePngIcon),
        onPressed: (){
          setState((){
            pageIndex = 1;
          });
        },//icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
             BoxShadow(
                color: Colors.black54,
                blurRadius: 2.0,
                offset:  Offset(0.0, 0.75)
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? SvgPicture.asset(AppAssets.healthTipBlue,height: 24,)
                  : SvgPicture.asset(AppAssets.healthTipGrey,height: 24,),
            ),
            // IconButton(
            //   enableFeedback: false,
            //   onPressed: () {
            //     setState(() {
            //       pageIndex = 2;
            //     });
            //   },
            //   icon: pageIndex == 2
            //       ? SvgPicture.asset(AppAssets.homeIcon,width: deviceWidth,height: deviceHeight,)
            //       : SvgPicture.asset(AppAssets.homeIcon),
            // ),
            const Icon(null),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? SvgPicture.asset(AppAssets.personBlue,height: 20,)
                  : SvgPicture.asset(AppAssets.personGrey,height: 20,),
            ),
          ],
        ),
      ),
    );
  }

  getLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

}


class ListItem {
  String? title;
  String? image;
  ListItem({
    this.title,
    this.image,
  });
}