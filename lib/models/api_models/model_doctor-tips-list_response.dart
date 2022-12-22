class ModelDoctorTipsListResponse {
  bool? status;
  String? messsage;
  List<Data>? data;

  ModelDoctorTipsListResponse({this.status, this.messsage, this.data});

  ModelDoctorTipsListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messsage = json['messsage'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['messsage'] = this.messsage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? name;
  int? tipsId;
  String? title;
  String? description;
  String? image;
  String? createdAt;
  String? imageUrl;
  String? specialist;
  String? userImage;

  Data(
      {this.userId,
        this.name,
        this.tipsId,
        this.title,
        this.description,
        this.image,
        this.createdAt,
        this.imageUrl,
        this.specialist,
        this.userImage});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    tipsId = json['tips_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    imageUrl = json['image_url'];
    specialist = json['specialist'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['tips_id'] = this.tipsId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['image_url'] = this.imageUrl;
    data['specialist'] = this.specialist;
    data['user_image'] = this.userImage;
    return data;
  }
}
