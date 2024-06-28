import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/and_ponits/and_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/login_models.dart';
import '../../../shared/componts.dart/constants.dart';
import '../../../shared/network/local/cache_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  late LoginModels loginModels;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTERS,
      data: {
        'name':name,
        'email': email,
        'password': password,
        'phone':phone,
      },
    ).then((value) {
      loginModels = LoginModels.formJson(dataJson: value.data);
      emit(RegisterSuccussState(loginModels));
    }).catchError((e) async {
      // ignore: avoid_print
      print(e.toString());
      emit(RegisterErrorState(e.toString()));
    });
  }

  IconData suffixIcon = Icons.remove_red_eye;
  bool isPassword = true;
  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.remove_red_eye : Icons.visibility_off;
    emit(RegisterChangePasswordSuffixIcon());
  }
}
