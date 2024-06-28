import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/home_Layout.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/componts.dart/componnts.dart';
import 'package:shop_app/shared/componts.dart/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../AppCubit/AppCubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccussState) {
          if (state.loginModels.status!) {
            showTost(msg: state.loginModels.message!, state: TostState.SUCCESS);
            CacheHelper.putData(
                    key: "token", value: state.loginModels.data!.token)
                .then((value) {
              token = state.loginModels.data!.token;
              navigatorFinish(context, HomeLayout());
            });
            showTost(msg: state.loginModels.message!, state: TostState.SUCCESS);
          } else {
            showTost(msg: state.loginModels.message!, state: TostState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubitLogin = LoginCubit.get(context);
        var cubitApp = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  cubitApp.changeModeApp();
                },
                icon: const Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "Login Now to browse our Hot offers ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.grey[700], fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                          controller: controllerEmail,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return "You should Enter Your Email address";
                            }
                            return null;
                          },
                          label: 'Email',
                          preFixIcon: Icons.email),
                      const SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                        onSubmitted: (p0) {
                          if (formKey.currentState!.validate()) {
                            cubitLogin.userLogin(
                                email: controllerEmail.text,
                                password: controllerPassword.text);
                          }
                        },
                        obscureText: cubitLogin.isPassword,
                        textInputType: TextInputType.visiblePassword,
                        controller: controllerPassword,
                        sufFixIconPress: () {
                          cubitLogin.changeSuffixIcon();
                        },
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return "Password is Too Short";
                          }
                          return null;
                        },
                        label: 'Password',
                        preFixIcon: Icons.lock,
                        sufFixIcon: cubitLogin.suffixIcon,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => defaultMartialButton(
                          btnOnPress: () {
                            if (formKey.currentState!.validate()) {
                              cubitLogin.userLogin(
                                email: controllerEmail.text,
                                password: controllerPassword.text,
                              );
                            }
                          },
                          label: 'login',
                          isUpperCase: true,
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't Have an account",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          defaultTextButton(
                              onPress: () {
                                navigatorTo(context, RegisterScreen());
                              },
                              label: "register")
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
