class ChangeFavModel {
  bool? status;
  String? message;

  ChangeFavModel({this.message, this.status});

  ChangeFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
