class ModelCatagreeListResponse {
  ModelCatagreeListResponse({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  List<Data>? data;

  ModelCatagreeListResponse.fromJson(Map<String, dynamic> json){
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
    required this.image,
    required this.imageUrl,
    required this.name,
  });
  late final int id;
  late final String image;
  late final String imageUrl;
  late final String name;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    imageUrl = json['image_url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['image_url'] = imageUrl;
    _data['name'] = name;
    return _data;
  }
}