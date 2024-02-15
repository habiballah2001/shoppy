import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../controller/app_cubit/shop_states.dart';
import '../../../res/material/CustomAppBar.dart';
import '../../../res/material/custom_container.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  const CategoryProductsScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(categoryName),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return cubit.categoryProductModel != null
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomContainer(
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              height: 80,
                              width: 80,
                              imageUrl: cubit
                                  .categoryProductModel!.data!.data[index].image
                                  .toString(),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.amberAccent,
                                strokeWidth: 1,
                              )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      cubit.categoryProductModel!.data!
                                          .data[index].name
                                          .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'EGP ${cubit.categoryProductModel!.data!.data[index].price}',
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          cubit.changeFavState(cubit
                                              .categoryProductModel!
                                              .data!
                                              .data[index]
                                              .id!);
                                          log('ID:${cubit.categoryProductModel!.data!.data[index].id} IN-CART:${cubit.categoryProductModel!.data!.data[index].inFavorites}');
                                        },
                                        icon: cubit.favorites[cubit
                                                        .categoryProductModel!
                                                        .data!
                                                        .data[index]
                                                        .id] !=
                                                    null &&
                                                cubit.favorites[cubit
                                                    .categoryProductModel!
                                                    .data!
                                                    .data[index]
                                                    .id]!
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
                                      IconButton(
                                        onPressed: () {
                                          cubit.changeCartState(
                                            cubit.categoryProductModel!.data!
                                                .data[index].id!,
                                          );
                                          log('ID:${cubit.categoryProductModel!.data!.data[index].id} IN-CART:${cubit.categoryProductModel!.data!.data[index].inCart}');
                                        },
                                        icon: cubit.carts[cubit
                                                        .categoryProductModel!
                                                        .data!
                                                        .data[index]
                                                        .id] !=
                                                    null &&
                                                cubit.carts[cubit
                                                    .categoryProductModel!
                                                    .data!
                                                    .data[index]
                                                    .id]!
                                            ? const Icon(
                                                Icons.shopping_cart_rounded,
                                                color: Colors.deepOrange,
                                                size: 20,
                                              )
                                            : const Icon(
                                                Icons
                                                    .add_shopping_cart_outlined,
                                                size: 20,
                                              ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: cubit.categoryProductModel!.data!.data.length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
