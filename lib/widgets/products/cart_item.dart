import 'package:flutter/material.dart';
import '../../controller/app_cubit/shop_cubit.dart';
import '../../models/cart/get_cart_model.dart';
import '../../shared/components/components.dart';
import '../../shared/custom_widgets/cached_image.dart';
import '../../shared/custom_widgets/custom_card.dart';
import '../../shared/custom_widgets/custom_texts.dart';

class CartItem extends StatelessWidget {
  final CartProductModel? product;

  const CartItem({
    Key? key,
    this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const double height = 100;

    var cubit = AppCubit.get(context);
    return product == null
        ? const SizedBox.shrink()
        : CustomCard(
            height: height,
            child: Row(
              children: [
                CustomCachedImage(
                  img: product!.image.toString(),
                  height: height,
                  width: 100,
                ),
                const SpaceWidth(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BodyLargeText(
                        product!.name.toString(),
                        maxLines: 2,
                      ),
                      const SpaceHeight(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TitleMediumText(
                                  '${product!.price} EGP',
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
                                        decoration: TextDecoration.lineThrough),
                                  ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeCartState(product!.id!);
                            },
                            child: const SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
