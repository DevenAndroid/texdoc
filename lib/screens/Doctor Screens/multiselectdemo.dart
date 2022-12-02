// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
//
// import '../../controller/doctor_Speciality_list_controller.dart';
// import '../../models/api_models/model_speciality_list_response.dart';
//
//
// class MultiSelectDropDownScreen extends StatelessWidget {
//   MultiSelectDropDownScreen({Key? key}) : super(key: key);
//
//   SpecialityListController controller = Get.put(SpecialityListController());
//
//   @override
//   Widget build(BuildContext context) {
//     List subjectData = [];
//
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       controller.getSpecialityListData();
//     });
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Multi Select DropDown"),
//       ),
//       body: Column(
//         children: [
//           GetBuilder<SpecialityListController>(builder: (controller) {
//             return Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: MultiSelectDialogField(
//                 items: controller.dropDownData,
//                 title: const Text(
//                   "Select Subject",
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 selectedColor: Colors.black,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.all(Radius.circular(30)),
//                   border: Border.all(
//                     color: Colors.black,
//                     width: 2,
//                   ),
//                 ),
//                 buttonIcon: const Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.blue,
//                 ),
//                 buttonText: const Text(
//                   "Select Your Subject",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//                 onConfirm: (results) {
//                   subjectData = [];
//                   for (var i = 0; i < controller.model.value.data!.length; i++) {
//                     ModelSpecialityListResponse data = results[i] as ModelSpecialityListResponse;
//
//                    /* print(data.data.v);
//                     print(data.subjectName);
//                     subjectData.add(data.subjectId);*/
//                   }
//                   print("data $subjectData");
//
//                   //_selectedAnimals = results;
//                 },
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }
