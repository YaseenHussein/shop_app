import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/AppCubit/AppCubit.dart';
import 'package:shop_app/AppCubit/observer.dart';
import 'package:shop_app/layout/home_Layout.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/on_branding.dart';
import 'package:shop_app/shared/componts.dart/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/colors.dart';

import 'AppCubit/AppStates.dart';
import 'firebase_options.dart';
import 'modules/login/cubit/cubit.dart';
import 'shared/style/thems.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.intil();
  bool? isDark = CacheHelper.getData(key: "isLight");
  bool? onBoarding = CacheHelper.getData(key: "onBoarding");
  token = CacheHelper.getData(key: "token");
  print(token);
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = OnBoarding();
  }
  runApp(MyApp(
    isDark: isDark,
    onBoarding: onBoarding,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  bool? onBoarding;
  Widget widget;
  MyApp(
      {super.key,
      required this.isDark,
      required this.onBoarding,
      required this.widget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..changeModeApp(shared: isDark)
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getProfileData(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThem,
            darkTheme: darkThem,
            themeMode: cubit.isLight ? ThemeMode.light : ThemeMode.dark,
            home: widget,
          );
        },
      ),
    );
  }
}
