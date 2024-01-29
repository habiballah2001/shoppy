import 'package:flutter/material.dart';

import '../../controller/app_cubit/shop_cubit.dart';
import '../../models/home/search_model.dart';
import '../../shared/custom_widgets/custom_card.dart';
import 'dart:developer';

class SearchProduct extends StatelessWidget {
  final SearchProductModel product;
  const SearchProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return CustomCard(
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              width: 100,
              height: 120,
              image: NetworkImage(product.image!),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${product.price}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.deepOrange, fontSize: 12),
                      ),
                      if (product.discount != 0)
                        Text(
                          '${product.oldPrice}',
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 7,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              cubit.favorites[product.id] != null &&
                                      cubit.favorites[product.id]!
                                  ? Colors.deepOrange
                                  : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          cubit.changeFavState(product.id!);
                          log(product.id.toString());
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
