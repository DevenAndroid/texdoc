import 'package:texdoc/resources/app_assets.dart';

class HomeModelResponse{
  final String? categoryName;
  final String? image;

  HomeModelResponse({this.categoryName, this.image,});
}

List<HomeModelResponse> HomeData = [

  HomeModelResponse(
      categoryName: "Nurse",
    image: AppAssets.nurse
  ),
  HomeModelResponse(
      categoryName: "General Medicine",
    image: AppAssets.medicine
  ),
  HomeModelResponse(
      categoryName: "Child Health",
    image: AppAssets.patient
  ),
  HomeModelResponse(
      categoryName: "Skin Problems",
    image: AppAssets.skinProblem
  ),
  HomeModelResponse(
      categoryName: "Sexual Reproductive Health",
    image: AppAssets.sexualRepro
  ),
  HomeModelResponse(
      categoryName: "General Surgery",
    image: AppAssets.surgery
  ),
  HomeModelResponse(
      categoryName: "Dentist",
    image: AppAssets.dentist
  ),
  HomeModelResponse(
      categoryName: "Mental & Emotional Health",
    image: AppAssets.mentalEmotional
  ),
  HomeModelResponse(
      categoryName: "Heart & Blood Health",
    image: AppAssets.heartBlood
  ),
];
