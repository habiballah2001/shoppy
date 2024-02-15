import 'package:flutter/material.dart';
import 'package:shoppy/res/material/plus_minus_widget.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../models/cart/get_cart_model.dart';
import '../../../res/components/components.dart';
import '../../../res/material/cached_image.dart';
import '../../../res/material/custom_card.dart';
import '../../../res/material/custom_texts.dart';

class CartItem extends StatelessWidget {
  final CartProductModel? product;
  final int quantity;
  final int cartId;

  const CartItem({
    Key? key,
    this.product,
    required this.quantity,
    required this.cartId,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BodyLargeText(
                          product!.name.toString(),
                          maxLines: 2,
                        ),
                        const SpaceHeight(),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              PlusMinusButtons(
                                addQuantity: () {
                                  cubit.updateQuantity(
                                      cartId: cartId, quantity: quantity + 1);
                                },
                                removeQuantity: () {
                                  cubit.updateQuantity(
                                      cartId: cartId, quantity: quantity - 1);
                                },
                                text: quantity.toString(),
                                delete: () {
                                  cubit.changeCartState(
                                    product!.id!,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
/*
*                           InkWell(
                            onTap: () {
                              cubit.changeCartState(
                                product!.id!,
                              );
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
*/
