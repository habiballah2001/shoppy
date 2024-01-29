/*
class UserModel{
  bool? status;
  String? message;
  UserDataModel? data;

  UserModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDataModel.fromJson(json['data']) : null ;
  }
}

class UserDataModel{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic points;
  dynamic credit;
  String? token;

  UserDataModel.fromJson(Map<String,dynamic> json){
     id = json['id'];
     name= json['name'];
     email= json['email'];
     phone= json['phone'];
     image= json['image'];
     points= json['points'];
     credit= json['credit'];
     token= json['token'];
  }
}

*/

class UserModel {
  bool? status;
  String? message;
  UserDataModel? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDataModel.fromJson(json['data']) : null;
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

class UserDataModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  double? credit;
  String? token;

  UserDataModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['points'] = points;
    data['credit'] = credit;
    data['token'] = token;
    return data;
  }
}
