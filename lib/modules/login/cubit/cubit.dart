import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/and_ponits/and_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/login_models.dart';
import '../../../shared/componts.dart/constants.dart';
import '../../../shared/network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginModels loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModels.formJson(dataJson: value.data);
      emit(LoginSuccussState(loginModel));
    }).catchError((e) async {
      // ignore: avoid_print
      print(e.toString());
      emit(LoginErrorState(e.toString()));
    });
  }

  IconData suffixIcon = Icons.remove_red_eye;
  bool isPassword = true;
  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.remove_red_eye : Icons.visibility_off;
    emit(LoginChangePasswordSuffixIcon());
  }
}
