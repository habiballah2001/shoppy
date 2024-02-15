import 'package:flutter/material.dart';
import 'package:shoppy/res/material/custom_texts.dart';
import 'package:shoppy/res/styles/colors.dart';

import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../res/material/cached_image.dart';
import '../../../res/material/custom_card.dart';

class ProductItem extends StatelessWidget {
  final int? itemIndex;
  final product;
  final Function()? press;
  const ProductItem({
    Key? key,
    this.itemIndex,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return product == null
        ? const SizedBox.shrink()
        : CustomCard(
            function: press,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: CustomCachedImage(
                        img: product!.image!,
                        fit: BoxFit.fitWidth,
                        height: 150,
                      )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              BodySmallText(
                                product!.name!,
                                maxLines: 2,
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  BodySmallText(
                                    '${product!.price} L.E',
                                    maxLines: 1,
                                    color: primaryColor,
                                  ),
                                  if (product!.discount != 0)
                                    Text(
                                      '${product!.oldPrice}',
                                      textAlign: TextAlign.end,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 7,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 35,
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.changeFavState(product!.id!);
                                        //snackBar(context, '${cubit.changeFavModel!.message}');
                                      },
                                      icon: cubit.favorites[product!.id] !=
                                                  null &&
                                              cubit.favorites[product!.id]!
                                          ? const Icon(
                                              Icons.favorite,
                                              size: 20,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              size: 20,
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 35,
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.changeCartState(
                                          product!.id!,
                                        );
                                      },
                                      icon: cubit.carts[product!.id] != null &&
                                              cubit.carts[product!.id]!
                                          ? const Icon(
                                              Icons.shopping_cart_rounded,
                                              color: Colors.deepOrange,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.add_shopping_cart_outlined,
                                              size: 20,
                                            ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (product!.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: const BodySmallText(
                      'DISCOUNT%',
                      color: Colors.white70,
                    ),
                  ),
              ],
            ),
          );
  }
}
