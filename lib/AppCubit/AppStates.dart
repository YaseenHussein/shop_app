import 'package:shop_app/models/favorites_model_change.dart';

import '../models/login_models.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeThemMode extends AppStates {}

class AppChangeBottomNivState extends AppStates {}

class AppLoadingHomeData extends AppStates {}

class AppSuccessHomeData extends AppStates {}

class AppErrorHomeData extends AppStates {}

class AppSuccessCategories extends AppStates {}

class AppErrorCategories extends AppStates {}

class AppLoadingFavorites extends AppStates {}

class AppSuccessFavorites extends AppStates {
  late final FavoritesChangeModel? model;
  AppSuccessFavorites(this.model);
}

class AppErrorFavorites extends AppStates {}

class AppLoadingGetFavorites extends AppStates {}

class AppSuccessGetFavorites extends AppStates {}

class AppErrorGetFavorites extends AppStates {}

class AppLoadingGetProfile extends AppStates {}

class AppSuccessGetProfile extends AppStates {}

class AppErrorGetProfile extends AppStates {}

class AppLoadingUpdateUserData extends AppStates {}

class AppSuccessUpdateUserData extends AppStates {
  final LoginModels? loginModels;

  AppSuccessUpdateUserData(this.loginModels);
}

class AppErrorUpdateUserData extends AppStates {}

class AppHartLightSearchLight extends AppStates {}
