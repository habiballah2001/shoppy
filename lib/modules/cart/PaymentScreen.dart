import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/controller/app_cubit/shop_states.dart';
import 'package:shoppy/widgets/orders/order_product.dart';
import '../../shared/components/components.dart';
import '../../controller/app_cubit/shop_cubit.dart';
import '../../shared/custom_widgets/CustomAppBar.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_texts.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController addressIdController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
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
                      InfoWidget(
                          label: 'Sub-total',
                          content:
                              'EGP ${cubit.getCartModel!.cartData!.subTotal}'),
                      InfoWidget(
                          label: 'total price',
                          content:
                              'EGP ${cubit.getCartModel!.cartData!.total}'),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                const TitleMediumText('Address'),
                const SpaceHeight(height: 5),
                const SizedBox(height: 16.0),
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
                      );
                    },
                    //separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: cubit.getCartModel!.cartData!.cartItems.length,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomButton(
            title: 'checkout',
            function: () {
              cubit.addOrder(context: context);
            },
          ),
        );
      },
    );
  }
}
