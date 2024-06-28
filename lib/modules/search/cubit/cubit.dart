import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/state.dart';
import 'package:shop_app/shared/componts.dart/constants.dart';
import 'package:shop_app/shared/network/and_ponits/and_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/searh_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  late SearchDataModel searchModel;
  void searchProduct({required text}) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      searchModel = SearchDataModel.fromJson(value.data);
      emit(SearchSuccussState());
    }).catchError((e) async {
      print(e.toString());
      emit(SearchErrorState());
    });
  }
}
