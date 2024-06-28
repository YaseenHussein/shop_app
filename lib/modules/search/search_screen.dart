import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/shared/componts.dart/componnts.dart';

import '../favorites/favorites_screen.dart';
import 'cubit/state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    buildTextField(
                        controller: searchController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "should Search Input not be Null";
                          }
                          return null;
                        },
                        label: "Search",
                        preFixIcon: Icons.search,
                        onSubmitted: (text) {
                          if (formKey.currentState!.validate()) {
                            cubit.searchProduct(text: text);
                          }
                        }),
                    if (state is SearchSuccussState) buildBodySearch(cubit),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildBodySearch(SearchCubit cubit) => Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildFavItem(
            cubit.searchModel.data!.data![index], context,
            isSearch: true),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0),
          child: Container(
            width: 1,
            height: 1,
            color: Colors.grey,
          ),
        ),
        itemCount: cubit.searchModel.data!.data!.length,
      ),
    );
