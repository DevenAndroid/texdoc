import 'package:texdoc/resources/app_assets.dart';

class OnBoardModelResponse{
  final String? image, title, description;

  OnBoardModelResponse({this.image, this.title, this.description,});
}

List<OnBoardModelResponse> OnBoardData = [

  OnBoardModelResponse(
      image: AppAssets.onBoardingOne,
      title: "Keep healthy\nwork-life balance",
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem."
  ),
  OnBoardModelResponse(
      image: AppAssets.onBoardingTwo,
      title: "Find your doctor\nonline",
      description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem."
  ),
  OnBoardModelResponse(
      image: AppAssets.onBoardingThree,
      title: "Healt check-\nup with best doctor",
      description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem."
  ),
];
