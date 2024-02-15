import 'package:flutter/material.dart';
import 'package:shoppy/res/components/components.dart';

import '../../controller/app_cubit/shop_cubit.dart';
import '../../models/category/category_model.dart';
import '../../res/material/custom_card.dart';
import '../../res/utils/custom_methods.dart';
import '../modules/categories/category_products_screen.dart';

class CategoryItem extends StatelessWidget {
  final CategoryItemModel model;
  final int index;
  const CategoryItem({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return GestureDetector(
      onTap: () {
        cubit.getCategoryProducts(
            cubit.categoriesModel!.categoriesData!.finalData[index].id!);
        Utils.navigateTo(
          widget: CategoryProductsScreen(
            categoryName:
                cubit.categoriesModel!.categoriesData!.finalData[index].name!,
          ),
          context: context,
        );
      },
      child: CustomCard(
        child: Row(
          children: [
            Image(
              width: 100,
              height: 100,
              image: NetworkImage(model.image!),
            ),
            const SpaceWidth(),
            Text(model.name!),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
