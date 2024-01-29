
import '../home/home_model.dart';

class CategoryProductModel {
  bool? status;
  CategoryDataModel? data;

  CategoryProductModel({
    required this.status,
    required this.data,
  });

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) {
    return CategoryProductModel(
      status: json['status'],
      data: json['data'] != null ? CategoryDataModel.fromJson(json['data']) : null,
    );
  }
}

class CategoryDataModel {
  int? currentPage;
  List<ProductModel> data = [];

  CategoryDataModel({
    required this.currentPage,
    required this.data,
  });

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(ProductModel.fromJson(element));
    });
  }
}

