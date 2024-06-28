class LoginModels {
  bool? status;
  String? message;
  UserData? data;
  LoginModels.formJson({required Map<String, dynamic>? dataJson}) {
    status = dataJson!['status'];
    message = dataJson['message'];
    data = dataJson['data'] != null
        ? UserData.fromJson(dataJson: dataJson['data'])
        : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserData.fromJson({required Map<String, dynamic>? dataJson}) {
    id = dataJson!['id'];
    name = dataJson['name'];
    email = dataJson['email'];
    phone = dataJson['phone'];
    image = dataJson['image'];
    points = dataJson['points'];
    credit = dataJson['credit'];
    token = dataJson['token'];
  }
}
