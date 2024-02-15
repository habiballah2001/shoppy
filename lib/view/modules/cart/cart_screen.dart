import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/res/material/empty_widget.dart';
import '../../../res/components/components.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../controller/app_cubit/shop_states.dart';
import '../../../res/material/custom_button.dart';
import '../../../res/utils/custom_methods.dart';
import '../../../view/widgets/products/cart_item.dart';
import 'PaymentScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    AppCubit.get(context).getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return cubit.getCartModel != null &&
                state is! LoadingChangeCartState &&
                state is! LoadingGetCartState
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: cubit.getCartModel!.cartData!.cartItems.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                final item = cubit
                                    .getCartModel!.cartData!.cartItems[index];
                                return CartItem(
                                  product: item.product,
                                  quantity: item.quantity!,
                                  cartId: item.id!,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(),
                              itemCount: cubit
                                  .getCartModel!.cartData!.cartItems.length,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoWidget(
                                    label: 'Sub-total',
                                    content:
                                        'EGP ${cubit.getCartModel!.cartData!.subTotal}'),
                                InfoWidget(
                                    label: 'total price',
                                    content:
                                        'EGP ${cubit.getCartModel!.cartData!.total}'),
                                CustomButton(
                                  radius: 30,
                                  function: () {
                                    Utils.navigateTo(
                                        widget: const PaymentScreen(),
                                        context: context);
                                  },
                                  title: 'CHECK OUT',
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : const Center(
                        child: EmptyWidget(
                          icon: Icons.remove_shopping_cart_outlined,
                          title: 'Empty',
                          withExpanded: false,
                        ),
                      ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
