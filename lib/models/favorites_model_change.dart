class FavoritesChangeModel {
  bool? status;
  String? message;
  FavoritesChangeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
