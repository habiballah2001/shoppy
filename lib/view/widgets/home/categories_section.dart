import 'package:flutter/material.dart';

import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../res/components/components.dart';
import '../../../res/material/custom_texts.dart';
import 'category_item_circle.dart';

Widget categoriesSection(context) {
  AppCubit cubit = AppCubit.get(context);
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleMediumText(
          'Categories',
        ),
        const SpaceHeight(),
        SizedBox(
          height: 100,
          child: cubit.categoriesModel != null
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CategoryItemCircle(
                    model:
                        cubit.categoriesModel!.categoriesData!.finalData[index],
                  ),
                  separatorBuilder: (context, index) => const SpaceWidth(),
                  itemCount:
                      cubit.categoriesModel!.categoriesData!.finalData.length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ],
    ),
  );
}
