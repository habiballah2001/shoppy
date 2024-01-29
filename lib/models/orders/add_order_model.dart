class AddOrderModel {
  bool? status;
  String? message;
  PaymentDataModel? data;

  AddOrderModel({this.status, this.message, this.data});

  AddOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? PaymentDataModel.fromJson(json['data']) : null;
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

class PaymentDataModel {
  String? paymentMethod;
  dynamic cost;
  dynamic vat;
  int? discount;
  int? points;
  dynamic total;
  int? id;

  PaymentDataModel({
    this.paymentMethod,
    this.cost,
    this.vat,
    this.discount,
    this.points,
    this.total,
    this.id,
  });

  PaymentDataModel.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    cost = json['cost'];
    vat = json['vat'];
    discount = json['discount'];
    points = json['points'];
    total = json['total'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_method'] = paymentMethod;
    data['cost'] = cost;
    data['vat'] = vat;
    data['discount'] = discount;
    data['points'] = points;
    data['total'] = total;
    data['id'] = id;
    return data;
  }
}
