class CategoriesModel {
  bool? status;
  CategoriesModelData? data;
  CategoriesModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesModelData.formJson(json['data']);
  }
}

class CategoriesModelData {
  int? currentPage;
  List<CategoriesElements> data = [];
  CategoriesModelData.formJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    for (var i = 0; i < json['data'].length; i++) {
      data.add(CategoriesElements.formJson(json['data'][i]));
    }
  }
}

class CategoriesElements {
  int? id;
  String? name;
  String? image;
  CategoriesElements.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
