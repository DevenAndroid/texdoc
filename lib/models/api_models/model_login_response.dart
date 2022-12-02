class ModelLoginResponse  {
  ModelLoginResponse ({
    required this.status,
    required this.message,
    required this.data,
  });
  bool? status;
  String? message;
  ModelLoginData? data;

  ModelLoginResponse .fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = ModelLoginData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class ModelLoginData {
  ModelLoginData({
    required this.token,
    required this.user,
  });
  late final String token;
  late final User user;

  ModelLoginData.fromJson(Map<String, dynamic> json){
    token = json['token'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.dateOfBirth,
    this.gender,
    required this.phone,
    this.profileImage,
    this.emailVerifiedAt,
    required this.isOtpVerified,
    required this.adminVerify,
    required this.otpVerfiy,
    this.userStatus,
    required this.createdAt,
    required this.updatedAt,
    this.town,
    required this.street,
    this.city,
    this.country,
    this.address,
    this.address2,
    this.state,
    this.categreeId,
    this.experience,
    this.medicalDegreeId,
    required this.specialistId,
    required this.rating,
    required this.review,
    required this.patientcount,
    required this.concentrationId,
    required this.institutionname,
    this.pinCode,
    required this.countryCode,
    required this.aboutMe,
    required this.avaliable,
    required this.documentVerified,
    required this.profileImageUrl,
  });
  late final int id;
  late final String name;
  late final String email;
  late final Null dateOfBirth;
  late final Null gender;
  late final String phone;
  late final Null profileImage;
  late final Null emailVerifiedAt;
  late final String isOtpVerified;
  late final int adminVerify;
  late final int otpVerfiy;
  late final Null userStatus;
  late final String createdAt;
  late final String updatedAt;
  late final Null town;
  late final String street;
  late final Null city;
  late final Null country;
  late final Null address;
  late final Null address2;
  late final Null state;
  late final Null categreeId;
  late final Null experience;
  late final Null medicalDegreeId;
  late final String specialistId;
  late final int rating;
  late final String review;
  late final int patientcount;
  late final String concentrationId;
  late final String institutionname;
  late final Null pinCode;
  late final String countryCode;
  late final String aboutMe;
  late final String avaliable;
  late final bool documentVerified;
  late final String profileImageUrl;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    dateOfBirth = null;
    gender = null;
    phone = json['phone'];
    profileImage = null;
    emailVerifiedAt = null;
    isOtpVerified = json['is_otp_verified'];
    adminVerify = json['admin_verify'];
    otpVerfiy = json['otp_verfiy'];
    userStatus = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    town = null;
    street = json['street'];
    city = null;
    country = null;
    address = null;
    address2 = null;
    state = null;
    categreeId = null;
    experience = null;
    medicalDegreeId = null;
    specialistId = json['specialist_id'];
    rating = json['rating'];
    review = json['review'];
    patientcount = json['patientcount'];
    concentrationId = json['concentration_id'];
    institutionname = json['institutionname'];
    pinCode = null;
    countryCode = json['country_code'];
    aboutMe = json['about_me'];
    avaliable = json['avaliable'];
    documentVerified = json['document_verified'];
    profileImageUrl = json['profile_image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['date_of_birth'] = dateOfBirth;
    _data['gender'] = gender;
    _data['phone'] = phone;
    _data['profile_image'] = profileImage;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['is_otp_verified'] = isOtpVerified;
    _data['admin_verify'] = adminVerify;
    _data['otp_verfiy'] = otpVerfiy;
    _data['user_status'] = userStatus;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['town'] = town;
    _data['street'] = street;
    _data['city'] = city;
    _data['country'] = country;
    _data['address'] = address;
    _data['address2'] = address2;
    _data['state'] = state;
    _data['categree_id'] = categreeId;
    _data['experience'] = experience;
    _data['medical_degree_id'] = medicalDegreeId;
    _data['specialist_id'] = specialistId;
    _data['rating'] = rating;
    _data['review'] = review;
    _data['patientcount'] = patientcount;
    _data['concentration_id'] = concentrationId;
    _data['institutionname'] = institutionname;
    _data['pin_code'] = pinCode;
    _data['country_code'] = countryCode;
    _data['about_me'] = aboutMe;
    _data['avaliable'] = avaliable;
    _data['document_verified'] = documentVerified;
    _data['profile_image_url'] = profileImageUrl;
    return _data;
  }
}