class ModelUserProfileResponse {
  ModelUserProfileResponse({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  Data? data;

  ModelUserProfileResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.phone,
    required this.email ,
    required this.specialist,
    required this.medicalDegree,
    required this.categreeId,
    required this.experience,
    required this.gender,
    required this.dateOfBirth,
    required this.aboutMe,
    required this.profileImage,
    required this.documents,

  });
  late final int id;
  late final String name;
  late final String phone;
  late final String email ;
  late final List<Specialist> specialist;
  late final List<MedicalDegree> medicalDegree;
  late final  List<String>? documents;
  late final String categreeId;
  late final String experience;
  late final String gender;
  late final String dateOfBirth;
  late final String aboutMe;
  late final String profileImage;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email  = json['email '];
    specialist = List.from(json['specialist']).map((e)=>Specialist.fromJson(e)).toList();
    medicalDegree = List.from(json['medical_degree']).map((e)=>MedicalDegree.fromJson(e)).toList();
    categreeId = json['categree_id'];
    experience = json['experience'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    aboutMe = json['about_me'];
    profileImage = json['profile_image'];
    documents = json['documents'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['email '] = email ;
    _data['specialist'] = specialist.map((e)=>e.toJson()).toList();
    _data['medical_degree'] = medicalDegree.map((e)=>e.toJson()).toList();
    _data['categree_id'] = categreeId;
    _data['experience'] = experience;
    _data['gender'] = gender;
    _data['date_of_birth'] = dateOfBirth;
    _data['about_me'] = dateOfBirth;
    _data['profile_image'] = profileImage;
    _data['documents'] = documents;
    return _data;
  }
}

class Specialist {
  Specialist({
    required this.id,
    required this.specialistname,
  });
  late final int id;
  late final String specialistname;

  Specialist.fromJson(Map<String, dynamic> json){
    id = json['id'];
    specialistname = json['specialistname'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['specialistname'] = specialistname;
    return _data;
  }
}

class MedicalDegree {
  MedicalDegree({
    required this.id,
    required this.medicaldegree,
  });
  late final int id;
  late final String medicaldegree;

  MedicalDegree.fromJson(Map<String, dynamic> json){
    id = json['id'];
    medicaldegree = json['medicaldegree'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['medicaldegree'] = medicaldegree;
    return _data;
  }
}