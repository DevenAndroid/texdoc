class ChatImage {
  bool? status;
  String? message;
  Data? data;

  ChatImage({this.status, this.message, this.data});

  ChatImage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? image;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? imageUrl;

  Data({this.image, this.updatedAt, this.createdAt, this.id, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
