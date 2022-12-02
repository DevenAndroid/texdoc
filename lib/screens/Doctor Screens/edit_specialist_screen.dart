// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:texdoc/app_utils/loading_indicator.dart';
// import 'package:texdoc/controller/doctor_Speciality_list_controller.dart';
// import 'package:texdoc/controller/get-doctor-tips-list_controller.dart';
// import 'package:texdoc/controller/get-user-profile_controller.dart';
// import 'package:texdoc/repository/speciality_update_repository.dart';
// import 'package:texdoc/resources/app_theme.dart';
// import 'package:texdoc/resources/strings.dart';
// import 'package:texdoc/routers/my_router.dart';
// import 'package:texdoc/app_utils/utils.dart';
// import 'package:texdoc/widgets/tok2DocButton.dart';
//
// import '../../models/api_models/model_speciality_list_response.dart';
// import '../../repository/doctor_Speciality_list_repository.dart';
//
// class EditSpecialistScreen extends StatefulWidget {
//   const EditSpecialistScreen({Key? key}) : super(key: key);
//
//   @override
//   State<EditSpecialistScreen> createState() => _EditSpecialistScreenState();
// }
//
// class _EditSpecialistScreenState extends State<EditSpecialistScreen> {
//   UserProfileController _profileController = Get.put(UserProfileController());
//   SpecialityListController controller = Get.put(SpecialityListController());
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(78.0), // here the desired height
//           child: AppBar(
//             backgroundColor: const Color(0xff0E7ECD),
//             title: const Text("Edit Specialist"),
//             centerTitle: true,
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(
//                 bottom: Radius.circular(30),
//               ),
//             ),
//             // ...
//           )),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Obx(() {
//           return !controller.isDataLoading.value
//               ? const Center(
//                   child: CircularProgressIndicator(
//                   color: AppTheme.primaryColor,
//                 ))
//               : SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     children: [
//                       const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Add Specialist',
//                             style: TextStyle(
//                                 height: 3.0,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           )),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                        ...List.generate(
//                          controller.model.value.data!.length,
//                                (index) =>
//                         Container(
//                           margin: const EdgeInsets.only(bottom: 10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                   color: controller.model.value.data![index].isselected == true
//                                       ? AppTheme.primaryColor
//                                       : AppTheme.greyColor
//                               )
//                           ),
//                           child: CheckboxListTile(
//                               checkColor: Colors.white,
//                               activeColor: AppTheme.primaryColor,
//                               contentPadding: const EdgeInsets.all(0),
//                               controlAffinity: ListTileControlAffinity.leading,
//                               // title: Text(checkListItems[index]["title"]),
//                               title: Text(controller.model.value.data![index].specialistname),
//                               value: controller.model.value.data![index].isselected,
//                               onChanged: (value) {
//                                 controller.model.value.data![index].isselected = value;
//                                 // if(controller.model.value.data![index].isselected)
//                                 //   {
//                                 //     controller.multipleSelected.add(controller.model.value.data![index].id);
//                                 //     setState(() {
//                                 //
//                                 //     });
//                                 //   }
//                                 // else
//                                 //   {
//                                 //     controller.multipleSelected.remove(controller.model.value.data![index].id);
//                                 //     setState(() {
//                                 //
//                                 //     });
//                                 //   }
//                                 setState(() {});
//                                 setState(() {});
//                               }
//                           ),
//                         )),
//                       SizedBox(
//                         height: 40.h,
//                       ),
//                       Tok2DocButton(AppStrings.save, () {
//                         // String selectedSpecilist = "";
//                         _profileController.specialistValue = "";
//                         for(var item in controller.model.value.data!){
//                           if(item.isselected == true) {
//                             if (_profileController.specialistValue == "") {
//                               _profileController.specialistValue = item.id.toString();
//                             }
//                             else {
//                               _profileController.specialistValue =
//                                   _profileController.specialistValue + "," + item.id.toString();
//                             }
//                           }
//                         }
//                         print(_profileController.specialistValue);
//                         if (_profileController.specialistValue == "") {
//                           showSnackBar('Edit Speciality Status',
//                               'Please Select atLeast on speciality.');
//                         }
//                         else {
//                           // print("dngjfhdnjgjfg$selectedSpecilist");
//                           showLoadingIndicatorDialog(context);
//                           doctorSpecialityUpdate(context, _profileController.specialistValue.toString(),
//                           ).then((value) {
//                             // _profileController.specialistValue = selectedSpecilist;
//                             showToast(value.message);
//                             if (value.status == true) {
//                               _profileController.getData();
//                               // for(var item in _profileController.model.value.data!.specialist){
//                               //   item.
//                               // };
//                               setState(() {
//
//                               });
//                               Navigator.pop(context);
//                             }
//                             return null;
//                           });
//                         }
//                       })
//                     ],
//                   ),
//                 );
//         }),
//       ),
//     );
//   }
// }
