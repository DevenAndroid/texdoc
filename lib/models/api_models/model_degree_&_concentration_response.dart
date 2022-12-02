import 'package:get/get.dart';

class ModelDegreeAndConcentrationResponse {
  bool? status;
  String? message;
  Data? data;

  ModelDegreeAndConcentrationResponse({this.status, this.message, this.data});

  ModelDegreeAndConcentrationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<MedicalDegree>? medicalDegree;
  List<Concentration>? concentration;

  Data({this.medicalDegree, this.concentration});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['medical_degree'] != null) {
      medicalDegree = <MedicalDegree>[];
      json['medical_degree'].forEach((v) {
        medicalDegree!.add(MedicalDegree.fromJson(v));
      });
    }
    if (json['concentration'] != null) {
      concentration = <Concentration>[];
      json['concentration'].forEach((v) {
        concentration!.add(Concentration.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicalDegree != null) {
      data['medical_degree'] =
          medicalDegree!.map((v) => v.toJson()).toList();
    }
    if (concentration != null) {
      data['concentration'] =
          concentration!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicalDegree {
  int? id;
  String? medicaldegree;
  RxBool? selected = false.obs;

  MedicalDegree({this.id, this.medicaldegree,this.selected});

  MedicalDegree.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicaldegree = json['medicaldegree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medicaldegree'] = medicaldegree;
    return data;
  }
}

class Concentration {
  int? id;
  String? concentration;

  Concentration({this.id, this.concentration});

  Concentration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    concentration = json['concentration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['concentration'] = concentration;
    return data;
  }
}
