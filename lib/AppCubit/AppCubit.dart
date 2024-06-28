import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_models.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/shared/componts.dart/constants.dart';
import 'package:shop_app/shared/network/and_ponits/and_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../models/categories_model.dart';
import '../models/favorites_data.dart';
import '../models/favorites_model_change.dart';
import '../modules/favorites/favorites_screen.dart';
import '../modules/products/products_screen.dart';
import '../modules/settings/settings_screen.dart';
import 'AppStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  late Map<int, bool> favorites = {};
  bool isLight = false;
  void changeModeApp({bool? shared}) {
    if (shared != null) {
      isLight = shared;
    } else {
      isLight = !isLight;
      CacheHelper.putData(key: "isLight", value: isLight);
    }
    emit(AppChangeThemMode());
  }

  int currentIndex = 0;
  List<Widget> screenOfHome = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeCurrentIndex({required int currentIndex}) {
    this.currentIndex = currentIndex;
    emit(AppChangeBottomNivState());
  }

  List<BottomNavigationBarItem> bottomNavigList = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];
  HomeModel? homeModel;
  void getHomeData() {
    emit(AppLoadingHomeData());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.formJson(value.data);
      // ignore: avoid_function_literals_in_foreach_calls
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      print(favorites);
      emit(AppSuccessHomeData());
    }).catchError((e) async {
      // ignore: avoid_print
      print(e.toString());
      emit(AppErrorHomeData());
    });
  }

  CategoriesModel? categories;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categories = CategoriesModel.formJson(value.data);
      //  print(homeModel.status.toString());
      emit(AppSuccessCategories());
    }).catchError((e) async {
      // ignore: avoid_print
      print(e.toString());
      emit(AppErrorCategories());
    });
  }

  FavoritesChangeModel? favoritesChangeModel;
  void changeFavoritesId(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(AppLoadingFavorites());
    DioHelper.postData(
            url: FAVORITES,
            data: {'product_id': productId},
            token: token,
            lang: 'ar')
        .then((value) {
      favoritesChangeModel = FavoritesChangeModel.fromJson(value.data);
      if (!favoritesChangeModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(AppSuccessFavorites(favoritesChangeModel));
    }).catchError((e) async {
      favorites[productId] = !favorites[productId]!;
      print(e.toString());
      emit(AppErrorFavorites());
    });
  }

  FavoritesDataModel? favoritesDataModel;
  void getFavoritesData() {
    emit(AppLoadingGetFavorites());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesDataModel = FavoritesDataModel.fromJson(value.data);
      emit(AppSuccessGetFavorites());
    }).catchError((e) async {
      // ignore: avoid_print
      print(e.toString());
      emit(AppErrorGetFavorites());
    });
  }

  LoginModels? loginModelsProfile;
  void getProfileData() {
    emit(AppLoadingGetProfile());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      loginModelsProfile = LoginModels.formJson(dataJson: value.data);
      print(loginModelsProfile!.data!.name);
      emit(AppLoadingGetProfile());
    }).catchError((e) async {
      // ignore: avoid_print
      print(e.toString());
      emit(AppLoadingGetProfile());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(AppLoadingUpdateUserData());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      loginModelsProfile = LoginModels.formJson(dataJson: value.data);
      print(loginModelsProfile!.data!.name);
      emit(AppSuccessUpdateUserData(loginModelsProfile));
    }).catchError((e) async {
      // ignore: avoid_print
      print(e.toString());
      emit(AppErrorUpdateUserData());
    });
  }

  bool hartLightSearch = false;
  void changeSearchState() {
    hartLightSearch = !hartLightSearch;
    emit(state);
  }
}
