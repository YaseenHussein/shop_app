import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/componts.dart/componnts.dart';
import 'package:shop_app/shared/style/colors.dart';

import '../../AppCubit/AppCubit.dart';
import '../../AppCubit/AppStates.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessFavorites) {
          if (!state.model!.status!) {
            showTost(msg: state.model!.message!, state: TostState.ERROR);
          } else {
            showTost(msg: state.model!.message!, state: TostState.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categories != null,
          builder: (context) {
            return buildProducts(cubit.homeModel, cubit.categories, context);
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget buildProducts(
    HomeModel? homeMode, CategoriesModel? categoriesModel, context) {
  var cubit = AppCubit.get(context);
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: homeMode!.data!.banners!
              .map(
                (e) => Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: getImage(e),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 200, //ارتفاع السليدر
            initialPage: 0, //من اي صفحة سوف يبداء
            viewportFraction: 1.0, //مقارد اخذ الصورة من الشاشة
            enableInfiniteScroll: true, //يجلس يلف على نفسة دائماً
            reverse: true, //عدم قلب الصور
            autoPlay: true,
            autoPlayInterval:
                const Duration(seconds: 3), //مقارد الوقف على الصورة
            autoPlayAnimationDuration:
                const Duration(seconds: 1), // مقارد الانتقال   بين الصور
            autoPlayCurve: Curves.fastOutSlowIn, //شكل الانتقال بين الصور
            scrollDirection: Axis.horizontal, //محور الانتقال
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                child: SizedBox(
                  height: 103,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildCategories(
                            categoriesModel.data!.data[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel!.data!.data.length),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "New Product",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.56,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            children: List.generate(
              homeMode.data!.products!.length,
              (index) => buildProduct(
                homeMode.data!.products![index],
                context,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

dynamic getImage(var e) {
  try {
    return NetworkImage("${e.image}");
  } catch (error) {
    return const NetworkImage(
        "https://www.arabforms.com/home/wp-content/uploads/2022/05/%D8%A7%D8%B9%D9%84%D8%A7%D9%86-780x470.jpg?v=1653734175");
  }
}

Widget buildProduct(ProductsModel homeMode, context) {
  var cubit = AppCubit.get(context);
  bool fav = cubit.favorites[homeMode.id]!;
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${homeMode.image}'),
              width: double.infinity,
              height: 200.0,
            ),
            if (homeMode.discount != 0)
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${homeMode.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$${homeMode.price.round()}",
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
                    if (homeMode.discount != 0)
                      Text(
                        "\$${homeMode.oldPrice.round()}",
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
                          cubit.changeFavoritesId(homeMode.id!);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: fav ? Colors.red : Colors.grey,
                          size: 22.0,
                        ))
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildCategories(CategoriesElements categoriesModelData) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            width: 100,
            height: 100,
            image: NetworkImage('${categoriesModelData.image}'),
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(.8),
            child: Text(
              "${categoriesModelData.name}".toUpperCase(),
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
