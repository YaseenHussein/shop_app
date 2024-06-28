import 'package:shop_app/models/login_models.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSuccussState extends LoginStates {
  final LoginModels loginModels;

  LoginSuccussState(this.loginModels);
}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePasswordSuffixIcon extends LoginStates {}
