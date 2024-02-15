import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/controller/app_cubit/shop_states.dart';
import 'package:shoppy/view/widgets/orders/order_product.dart';
import '../../../res/components/components.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../res/material/CustomAppBar.dart';
import '../../../res/material/custom_button.dart';
import '../../../res/material/custom_outlined_button.dart';
import '../../../res/material/custom_texts.dart';

import '../../../res/utils/payment/stripe_payment_manager.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController addressIdController = TextEditingController();
  bool _isCash = true;

  dynamic subTotal;
  dynamic total;

  @override
  void initState() {
    super.initState();
    AppCubit cubit = AppCubit.get(context);
    subTotal = cubit.getCartModel!.cartData!.subTotal;
    total = cubit.getCartModel!.cartData!.total;
  }

  @override
  void dispose() {
    addressIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: const CustomAppBar(
            title: TitleMediumText('Checkout'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoWidget(label: 'Sub-total', content: 'EGP $subTotal'),
                      InfoWidget(label: 'total price', content: 'EGP $total'),
                    ],
                  ),
                ),
                const Divider(),
                CustomOutlinedButton(
                  radius: 1,
                  borderColor: _isCash == true ? Colors.green : Colors.grey,
                  title: 'Cash',
                  function: () {
                    setState(() {
                      _isCash = true;
                    });
                    log(_isCash.toString());
                  },
                ),
                CustomOutlinedButton(
                  radius: 1,
                  borderColor: _isCash == true ? Colors.grey : Colors.green,
                  title: 'PayPal',
                  leadIcon: Icons.paypal,
                  iconColor: Colors.blue,
                  function: () {
                    setState(() {
                      _isCash = false;
                    });
                    log(_isCash.toString());
                  },
                ),
                const Divider(
                  thickness: 2,
                ),
                const TitleMediumText('Address'),
                const SpaceHeight(height: 5),
                const TitleMediumText(
                  'Order products',
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return OrderProduct(
                        orderProduct: cubit
                            .getCartModel!.cartData!.cartItems[index].product,
                        quantity: cubit
                            .getCartModel!.cartData!.cartItems[index].quantity!,
                      );
                    },
                    itemCount: cubit.getCartModel!.cartData!.cartItems.length,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomButton(
            title: 'checkout',
            function: () {
              if (_isCash == true) {
                cubit.addOrder(context: context);
              } else {
                PaymentManager.makePayment(total, "usd");
              }
            },
          ),
        );
      },
    );
  }
}
