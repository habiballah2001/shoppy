class GetFavModel {
  bool? status;
  String? message;
  FavDataModel? data;

  GetFavModel({this.status, this.message, this.data});

  GetFavModel.fromJson(json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FavDataModel.fromJson(json['data']) : null;
  }
}

class FavDataModel {
  int? currentPage;
  List<FavItemsModel> dataList = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  dynamic perPage;
  String? prevPageUrl;
  dynamic to;
  dynamic total;

  FavDataModel({
    this.currentPage,
    required this.dataList,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  FavDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      dataList = <FavItemsModel>[];
      json['data'].forEach((v) {
        dataList.add(FavItemsModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavItemsModel {
  int? id;
  FavProductModel? product;

  FavItemsModel({this.id, this.product});

  FavItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null
        ? FavProductModel.fromJson(json['product'])
        : null;
  }
}

class FavProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  FavProductModel({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  FavProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
