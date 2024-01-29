class OrderDetailsModel {
  bool? status;
  String? message;
  OrderDetailsDataModel? data;

  OrderDetailsModel({this.status, this.message, this.data});

  OrderDetailsModel.fromJson(json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? OrderDetailsDataModel.fromJson(json['data'])
        : null;
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

class OrderDetailsDataModel {
  int? id;
  dynamic cost;
  dynamic discount;
  dynamic points;
  dynamic vat;
  dynamic total;
  dynamic pointsCommission;
  String? promoCode;
  String? paymentMethod;
  String? date;
  String? status;
  Address? address;
  List<OrderProductModel> products = [];

  OrderDetailsDataModel({
    this.id,
    this.cost,
    this.discount,
    this.points,
    this.vat,
    this.total,
    this.pointsCommission,
    this.promoCode,
    this.paymentMethod,
    this.date,
    this.status,
    this.address,
    required this.products,
  });

  OrderDetailsDataModel.fromJson(json) {
    id = json['id'];
    cost = json['cost'];
    discount = json['discount'];
    points = json['points'];
    vat = json['vat'];
    total = json['total'];
    pointsCommission = json['points_commission'];
    promoCode = json['promo_code'];
    paymentMethod = json['payment_method'];
    date = json['date'];
    status = json['status'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['products'] != null) {
      products = <OrderProductModel>[];
      json['products'].forEach((v) {
        products.add(OrderProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cost'] = cost;
    data['discount'] = discount;
    data['points'] = points;
    data['vat'] = vat;
    data['total'] = total;
    data['points_commission'] = pointsCommission;
    data['promo_code'] = promoCode;
    data['payment_method'] = paymentMethod;
    data['date'] = date;
    data['status'] = status;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['products'] = products.map((v) => v.toJson()).toList();
    return data;
  }
}

class Address {
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;

  Address(
      {this.id,
      this.name,
      this.city,
      this.region,
      this.details,
      this.notes,
      this.latitude,
      this.longitude});

  Address.fromJson(json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['region'] = region;
    data['details'] = details;
    data['notes'] = notes;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class OrderProductModel {
  int? id;
  int? quantity;
  dynamic price;
  String? name;
  String? image;

  OrderProductModel(
      {this.id, this.quantity, this.price, this.name, this.image});

  OrderProductModel.fromJson(json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['price'] = price;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
