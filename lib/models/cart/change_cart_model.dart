
class ChangeCartModel {
  bool? status;
  String? message;

  ChangeCartModel({required this.message,required this.status});

  factory ChangeCartModel.fromJson(Map<String, dynamic> json) {
    return ChangeCartModel(
      status: json['status'],
      message: json['message'],
    );
  }
}

