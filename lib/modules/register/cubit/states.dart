import 'package:shop_app/models/login_models.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterSuccussState extends RegisterStates {
  final LoginModels loginModels;

  RegisterSuccussState(this.loginModels);
}

class RegisterLoadingState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangePasswordSuffixIcon extends RegisterStates {}
