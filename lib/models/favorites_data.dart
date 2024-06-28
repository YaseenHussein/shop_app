class FavoritesDataModel {
  bool? status;
  DataFavorites? data;
  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataFavorites.fromJson(json['data']);
  }
}

class DataFavorites {
  int? currentPage;
  List<Data>? data = [];

  DataFavorites.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    for (int i = 0; i < json['data'].length; i++) {
      data!.add(Data.fromJson(json['data'][i]));
    }
  }
}

class Data {
  int? id;
  Product? product;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
