import 'package:flutter/material.dart';
import '../../shared/components/components.dart';
import '../../shared/custom_widgets/cached_image.dart';
import '../../shared/custom_widgets/custom_card.dart';
import '../../shared/custom_widgets/custom_texts.dart';

class OrderProduct extends StatelessWidget {
  final orderProduct;
  const OrderProduct({
    Key? key,
    required this.orderProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var cubit = ShopCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomCard(
        radius: 5,
        color: Colors.grey[100],
        child: Row(
          children: [
            CustomCachedImage(
              img: orderProduct.image.toString(),
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
            const SpaceWidth(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BodyLargeText(
                    orderProduct.name.toString(),
                    maxLines: 2,
                    overFlow: TextOverflow.ellipsis,
                  ),
                  TitleMediumText(orderProduct.price.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
