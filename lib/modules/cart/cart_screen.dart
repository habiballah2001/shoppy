import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/shared/custom_widgets/empty_widget.dart';
import '../../shared/components/components.dart';
import '../../controller/app_cubit/shop_cubit.dart';
import '../../controller/app_cubit/shop_states.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/services/custom_methods.dart';
import '../../widgets/products/cart_item.dart';
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
                state is! LoadingCartState
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: cubit.getCartModel!.cartData!.cartItems.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Dismissible(
                                    onDismissed: (DismissDirection d) {
                                      cubit.changeCartState(
                                        cubit.getCartModel!.cartData!
                                            .cartItems[index].id!,
                                      );
                                    },
                                    key: UniqueKey(),
                                    child: CartItem(
                                      product: cubit.getCartModel!.cartData!
                                          .cartItems[index].product,
                                    ));
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
                                    label: 'Sub-total : ',
                                    content:
                                        'EGP ${cubit.getCartModel!.cartData!.subTotal}'),
                                InfoWidget(
                                    label: 'total price : ',
                                    content:
                                        'EGP ${cubit.getCartModel!.cartData!.total}'),
                                CustomButton(
                                  width: double.infinity,
                                  height: 40,
                                  radius: 30,
                                  function: () {
                                    CustomMethods.navigateTo(
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
