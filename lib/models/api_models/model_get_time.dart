class ModelGetTime {
  bool? status;
  String? message;
  List<Data>? data;

  ModelGetTime({this.status, this.message, this.data});

  ModelGetTime.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? day;
  String? open;
  String? close;
  bool? isAvailable;

  Data({this.day, this.open, this.close, this.isAvailable});

  Data.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    open = json['open'];
    close = json['close'];
    isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['open'] = this.open;
    data['close'] = this.close;
    data['is_available'] = this.isAvailable;
    return data;
  }
}
