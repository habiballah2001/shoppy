class CategoriesModel {
  bool? status;
  String? message;
  CategoriesDataModel? categoriesData;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoriesData = json['data'] != null ? CategoriesDataModel.fromJson(json['data']) : null;
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<CategoryItemModel> finalData = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach(
      (element) {
        finalData.add(CategoryItemModel.fromJson(element));
      },
    );
  }
}

class CategoryItemModel {
  int? id;
  String? name;
  String? image;

CategoryItemModel({this.id,this.image,this.name});

  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
