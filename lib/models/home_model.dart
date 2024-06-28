class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel();
  HomeModel.formJson(Map<String, dynamic>? data) {
    status = data!['status'];
    this.data = HomeDataModel.formJson(data['data']);
  }
}

class HomeDataModel {
  List<BannersModel>? banners = [];
  List<ProductsModel>? products = [];
  HomeDataModel.formJson(Map<String, dynamic>? data) {
    for (var i = 0; i < data!['banners'].length; i++) {
      banners!.add(BannersModel.formJson(data['banners'][i]));
    }
    for (var i = 0; i < data['products'].length; i++) {
      products!.add(ProductsModel.formJson(data['products'][i]));
    }
  }
}

class BannersModel {
  int? id;
  String? image;
  BannersModel.formJson(Map<String, dynamic>? data) {
    id = data!['id'];
    image = data['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  ProductsModel.formJson(Map<String, dynamic>? data) {
    id = data!['id'];
    price = data['price'];
    oldPrice = data['old_price'];
    discount = data['discount'];
    image = data['image'];
    name = data['name'];
    inFavorites = data['in_favorites'];
    inCart = data['in_cart'];
  }
}
