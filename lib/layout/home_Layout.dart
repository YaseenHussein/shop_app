import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/on_branding.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/componts.dart/componnts.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../AppCubit/AppCubit.dart';
import '../AppCubit/AppStates.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Shop App"),
            actions: [
              IconButton(
                  onPressed: () {
                    navigatorTo(context, const SearchScreen());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.screenOfHome[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeCurrentIndex(currentIndex: index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavigList,
          ),
        );
      },
    );
  }
}
