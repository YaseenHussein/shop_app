import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../AppCubit/AppCubit.dart';
import '../../AppCubit/AppStates.dart';
import '../../shared/componts.dart/componnts.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController? controllerName = TextEditingController();
  TextEditingController? controllerEmail = TextEditingController();
  TextEditingController? controllerPhone = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AppSuccessUpdateUserData) {
          if (state.loginModels!.status!) {
            showTost(
                msg: state.loginModels!.message!, state: TostState.SUCCESS);
          } else {
            showTost(msg: state.loginModels!.message!, state: TostState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        controllerName!.text = cubit.loginModelsProfile!.data!.name!;
        controllerEmail!.text = cubit.loginModelsProfile!.data!.email!;
        controllerPhone!.text = cubit.loginModelsProfile!.data!.phone!;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (state is AppLoadingUpdateUserData)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                buildTextField(
                  controller: controllerName,
                  label: "Name",
                  preFixIcon: Icons.person,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Name should be not Null";
                    }
                    return null;
                  },
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                buildTextField(
                  controller: controllerEmail,
                  label: "Email",
                  preFixIcon: Icons.email,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Email should be not Null";
                    }
                    return null;
                  },
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                buildTextField(
                  controller: controllerPhone,
                  label: "Phone",
                  preFixIcon: Icons.phone,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "Phone should be not Null";
                    }
                    return null;
                  },
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                defaultMartialButton(
                    label: "UPDATE",
                    btnOnPress: () {
                      if (formKey.currentState!.validate()) {
                        cubit.updateUserData(
                          email: controllerEmail!.text,
                          name: controllerName!.text,
                          phone: controllerPhone!.text,
                        );
                      }
                    }),
                const SizedBox(
                  height: 20.0,
                ),
                defaultMartialButton(
                    label: "LOGOUT",
                    btnOnPress: () {
                      CacheHelper.removeShared(key: "token").then((value) {
                        if (value) {
                          navigatorFinish(context, const LoginScreen());
                        }
                      });
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
