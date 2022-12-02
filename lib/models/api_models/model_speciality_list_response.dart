import 'package:get/get.dart';

class ModelSpecialityListResponse {
  ModelSpecialityListResponse({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  List<Data>? data;

  ModelSpecialityListResponse.fromJson(Map<String, dynamic> json){
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
    required this.specialistname,
    this.selected
  });
  RxBool? selected = false.obs;
  late final int id;
  late final String specialistname;

  Data.fromJson(Map<String, dynamic> json){
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