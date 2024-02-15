import 'package:flutter/material.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../view/modules/home/product_details_screen.dart';
import '../../../res/material/custom_texts.dart';
import '../../../res/utils/custom_methods.dart';
import '../products/product_item.dart';

Widget productsSection(context) {
  AppCubit cubit = AppCubit.get(context);

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleMediumText(
          'Products',
        ),
        cubit.homeModel != null
            ? GridView.count(
                mainAxisSpacing: 2,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.6,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                  cubit.homeModel!.data!.products.length,
                  (index) => ProductItem(
                    itemIndex: index,
                    product: cubit.homeModel!.data!.products[index],
                    press: () {
                      Utils.navigateTo(
                        widget: DetailsScreen(
                          product: cubit.homeModel!.data!.products[index],
                        ),
                        context: context,
                      );
                    },
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ],
    ),
  );
}
