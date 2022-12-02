

import 'package:texdoc/resources/app_assets.dart';

class DoctorsListModelResponse{
  final String? doctorName;
  final String? positionSpeciality, experience;
  final String? image;

  DoctorsListModelResponse( {this.doctorName, this.positionSpeciality, this.experience, this.image,});
}

List<DoctorsListModelResponse> DoctorsListData = [

  DoctorsListModelResponse(
      doctorName: "Dr. kamal",
      positionSpeciality:"Sr. Psycology",
      image: AppAssets.doctorA,
    experience: "Ex. 10 yr",
  ),
  DoctorsListModelResponse(
      doctorName: "Dr. Abhishek",
      positionSpeciality: "Sr. Gastrology",
      image: AppAssets.doctorB,
    experience: "Ex. 15 yr",
  ),
  DoctorsListModelResponse(
      doctorName: "Dr. Sunil",
      positionSpeciality: "Sr. Cardiology",
      image: AppAssets.doctorC,
    experience: "Ex. 23 yr",
  ),
  DoctorsListModelResponse(
      doctorName: "Dr. Orthopedic",
      positionSpeciality: "Sr. Orthopedic",
      image: AppAssets.doctorD,
    experience: "Ex. 24 yr",
  ),
  DoctorsListModelResponse(
      doctorName: "Dr. Chirag Pratap",
      positionSpeciality: "Sr. Orthopedic",
      image: AppAssets.doctorE,
    experience: "Ex. 26 yr",
  ),
  DoctorsListModelResponse(
      doctorName: "Dr. Lokesh Kumar",
      positionSpeciality: "Sr. Orthopedic",
      image: AppAssets.doctorF,
    experience: "Ex. 5 yr",
  ),
  DoctorsListModelResponse(
      doctorName: "Dr. kartik",
      positionSpeciality: "Sr. Orthopedic",
      image: AppAssets.doctorG,
    experience: "Ex. 30 yr",
  ),
  DoctorsListModelResponse(
      doctorName: "Dr. Varun",
      positionSpeciality: "Sr. Orthopedic",
      image: AppAssets.doctorH,
    experience: "Ex. 38 yr",
  ),
];
