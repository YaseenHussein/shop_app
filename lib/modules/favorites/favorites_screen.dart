import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/AppCubit/AppCubit.dart';
import 'package:shop_app/AppCubit/AppStates.dart';
import 'package:shop_app/models/favorites_data.dart';
import 'package:shop_app/models/favorites_model_change.dart';
import 'package:shop_app/shared/style/colors.dart';

import '../../shared/componts.dart/componnts.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
          condition: state is! AppLoadingGetFavorites,
          builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavItem(
                    AppCubit.get(context)
                        .favoritesDataModel!
                        .data!
                        .data![index]
                        .product,
                    context),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Container(
                    width: 1,
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                itemCount: AppCubit.get(context)
                    .favoritesDataModel!
                    .data!
                    .data!
                    .length,
              ),
          fallback: (context) {
            showTost(msg: "not", state: TostState.WARNING);
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

Widget buildFavItem(var product, context, {bool isSearch = false}) {
  var cubit = AppCubit.get(context);
  bool? fav = cubit.favorites[product!.id];
  print(fav);
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product.image.toString()),
                width: 120,
              ),
              if (!isSearch)
                if (product.discount != 0)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "DisCount".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "\$${product.price}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: defaultColorThem,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (!isSearch)
                      if (product.discount != 0)
                        Text(
                          "\$${product.oldPrice}",
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    const Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          print("ok");
                          AppCubit.get(context).changeFavoritesId(product.id!);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: fav! ? Colors.red : Colors.grey,
                          size: 22.0,
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
