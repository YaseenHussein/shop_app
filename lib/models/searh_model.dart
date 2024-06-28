class SearchDataModel {
  bool? status;
  DataSearch? data;
  SearchDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataSearch.fromJson(json['data']);
  }
}

class DataSearch {
  int? currentPage;
  List<Product>? data = [];

  DataSearch.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    for (int i = 0; i < json['data'].length; i++) {
      data!.add(Product.fromJson(json['data'][i]));
    }
  }
}

class Product {
  int? id;
  dynamic price;
  // dynamic oldPrice;
  // int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    // oldPrice = json['old_price'];
    // discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
