
import 'package:get/get.dart';
import 'package:texdoc/models/api_models/model_doctor-tips-list_response.dart';
import 'package:texdoc/repository/doctor-tips-list_repository.dart';

class DoctorTipsListController extends GetxController{

  Rx<ModelDoctorTipsListResponse> model = ModelDoctorTipsListResponse().obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }
  getData(){
    getTipsListData().then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }
}