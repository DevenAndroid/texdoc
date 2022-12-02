import 'package:get/get.dart';
import 'package:texdoc/models/api_models/model_degree_&_concentration_response.dart';
import 'package:texdoc/repository/medical_&_conversation_list_repository.dart';

class MedicalDegreeConversationListController extends GetxController{

  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getData();
  }

}