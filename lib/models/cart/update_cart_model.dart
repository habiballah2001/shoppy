class UpdateCartModel {
  bool? status;
  String? message;

  UpdateCartModel({this.status, this.message});

  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
