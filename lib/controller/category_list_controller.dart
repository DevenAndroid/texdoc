import 'package:get/get.dart';
import 'package:texdoc/models/api_models/model_category_list_response.dart';
import 'package:texdoc/repository/category_list_repository.dart';

class CategoryListController extends GetxController {
  Rx<ModelCatagreeListResponse> model = ModelCatagreeListResponse().obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    print("objectdsd");
  }
  getData(){
    catagreeListData(Get.context).then((value) {
      isDataLoading.value = true;
      model.value = value;
      return null;
    });
  }

}