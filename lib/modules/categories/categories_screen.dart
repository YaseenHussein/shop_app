import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/style/colors.dart';

import '../../AppCubit/AppCubit.dart';
import '../../AppCubit/AppStates.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildCatItem(cubit.categories!.data!.data[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 20,
                  ),
                  child: Container(
                    width: 1,
                    height: 1,
                    decoration: BoxDecoration(color: Colors.grey[400]),
                  ),
                ),
            itemCount: cubit.categories!.data!.data.length);
      },
    );
  }
}

Widget buildCatItem(CategoriesElements model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Expanded(
        child: Row(
          children: [
            Image(
                width: 110, height: 110, image: NetworkImage("${model.image}")),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                "${model.name}".toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
