import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/componts.dart/constants.dart';

import '../../AppCubit/AppCubit.dart';
import '../../layout/home_Layout.dart';
import '../../shared/componts.dart/componnts.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    TextEditingController controllerPhone = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is RegisterSuccussState) {
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
      }, builder: (context, state) {
        var cubitRegister = RegisterCubit.get(context);
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
                        "Register",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "Register Now to browse our Hot offers ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.grey[700], fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                          controller: controllerName,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return "You should Enter Your Name ";
                            }
                            return null;
                          },
                          label: 'Name',
                          preFixIcon: Icons.person),
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
                            cubitRegister.userRegister(
                              name: controllerName.text,
                              email: controllerEmail.text,
                              password: controllerPassword.text,
                              phone: controllerPhone.text,
                            );
                          }
                        },
                        obscureText: cubitRegister.isPassword,
                        textInputType: TextInputType.visiblePassword,
                        controller: controllerPassword,
                        sufFixIconPress: () {
                          cubitRegister.changeSuffixIcon();
                        },
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return "Password is Too Short";
                          }
                          return null;
                        },
                        label: 'Password',
                        preFixIcon: Icons.lock,
                        sufFixIcon: cubitRegister.suffixIcon,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildTextField(
                          controller: controllerPhone,
                          textInputType: TextInputType.phone,
                          validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return "You should Enter Your Phone Number";
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          preFixIcon: Icons.phone),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => defaultMartialButton(
                          btnOnPress: () {
                            if (formKey.currentState!.validate()) {
                              cubitRegister.userRegister(
                                name: controllerName.text,
                                email: controllerEmail.text,
                                password: controllerPassword.text,
                                phone: controllerPhone.text,
                              );
                            }
                          },
                          label: 'Register',
                          isUpperCase: true,
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
