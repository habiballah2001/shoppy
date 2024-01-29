import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/shared/custom_widgets/CustomAppBar.dart';
import '../../controller/app_cubit/shop_cubit.dart';
import '../../controller/app_cubit/shop_states.dart';
import '../../models/home/home_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/custom_widgets/cached_image.dart';
import '../../shared/custom_widgets/choose_color/color_option_cubit/color_selector_cubit.dart';
import '../../shared/custom_widgets/choose_color/color_option_cubit/color_selector_state.dart';
import '../../shared/custom_widgets/choose_color/custom_color_option.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_card.dart';
import '../../shared/custom_widgets/custom_container.dart';
import '../../shared/custom_widgets/custom_outlined_button.dart';
import '../../shared/custom_widgets/custom_texts.dart';
import 'dart:developer';

class DetailsScreen extends StatefulWidget {
  final ProductModel? product;
  const DetailsScreen({
    Key? key,
    this.product,
  }) : super(key: key);
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
          title: const TitleLargeText(
            'Details',
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  CustomContainer(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomCachedImage(img: widget.product!.image!),
                        ),
                        BlocBuilder<ColorSelectorCubit, ColorSelectorState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Builder(
                                builder: (context) {
                                  return CustomColorOption(
                                    colorsOptions: Lists.colors,
                                    selectedColor: state.newColor,
                                    onColorChanged: (color) {
                                      BlocProvider.of<ColorSelectorCubit>(
                                              context)
                                          .changeColor(color);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () {
                        cubit.changeFavState(widget.product!.id!);
                        log('ID:${widget.product!.id} IN-CART:${widget.product!.inFavorites}');
                        //snackBar(context, '${cubit.changeFavModel!.message}');
                      },
                      elevation: 0,
                      child: cubit.favorites[widget.product!.id] != null &&
                              cubit.favorites[widget.product!.id]!
                          ? const Icon(
                              Icons.favorite,
                              size: 24,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                              size: 24,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: CustomCard(
              radius: 30,
              padding: 8,
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpaceHeight(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: HeadSmallText(
                      widget.product!.name!,
                    ),
                  ),
                  HeadSmallText(
                    'price : ${widget.product!.price}\$',
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      height: size.height * .24,
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Text(widget.product!.description!),
                          ],
                        ),
                      ),
                    ),
                  ),
                  cubit.carts[widget.product!.id] != null &&
                          cubit.carts[widget.product!.id]!
                      ? CustomButton(
                          width: double.infinity,
                          height: 50,
                          radius: 30,
                          function: () {
                            cubit.changeCartState(widget.product!.id!);
                            log('ID======${widget.product!.id} IN-CART======${widget.product!.inCart}');
                          },
                          icon: Icons.remove_shopping_cart_outlined,
                          title: 'Remove From Cart',
                        )
                      : CustomOutlinedButton(
                          height: 50,
                          title: 'Add To Cart',
                          leadIcon: Icons.shopify,
                          function: () {
                            cubit.changeCartState(widget.product!.id!);
                            log('ID======${widget.product!.id} IN-CART======${widget.product!.inCart}');
                          },
                        ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
