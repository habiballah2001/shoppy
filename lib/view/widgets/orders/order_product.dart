import 'package:flutter/material.dart';
import '../../../res/material/cached_image.dart';
import '../../../res/material/custom_card.dart';
import '../../../res/material/custom_texts.dart';

class OrderProduct extends StatelessWidget {
  final orderProduct;
  final int quantity;

  const OrderProduct({
    Key? key,
    required this.orderProduct,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var cubit = ShopCubit.get(context);
    return CustomCard(
      radius: 5,
      child: Row(
        children: [
          CustomCachedImage(
            img: orderProduct.image.toString(),
            height: 90,
            width: 90,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BodyLargeText(
                    orderProduct.name.toString(),
                    maxLines: 2,
                    overFlow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      TitleMediumText(orderProduct.price.toString()),
                      const Spacer(),
                      BodyLargeText('Qty:$quantity'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
