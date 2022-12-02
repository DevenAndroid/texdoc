class ModelDoctorTipsListResponse {
  ModelDoctorTipsListResponse({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  List<Data>? data;

  ModelDoctorTipsListResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int userId;
  late final String title;
  late final String description;
  late final String image;
  late final String imageUrl;
  late final String createdAt;
  late final String updatedAt;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    image = json['image']??"";
    imageUrl = json['image_url']??"";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['title'] = title;
    _data['description'] = description;
    _data['image'] = image;
    _data['image_url'] = imageUrl;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}