import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/res/components/components.dart';
import 'package:shoppy/res/material/CustomAppBar.dart';
import 'package:shoppy/res/material/custom_button.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../controller/app_cubit/shop_states.dart';
import '../../../res/material/custom_texts.dart';
import '../../../view/widgets/orders/order_product.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;
  const OrderDetailsScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    AppCubit.get(context).getOrderDetails(widget.orderId);
    log(widget.orderId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: const CustomAppBar(
          title: TitleLargeText('Order Details'),
        ),
        body: state is! LoadingGetOrderDetailsState
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InfoWidget(
                            label: 'Total',
                            content:
                                '${cubit.getOrderDetailsModel!.data!.total} EGP'),
                        InfoWidget(
                            label: 'Products',
                            content:
                                '${cubit.getOrderDetailsModel!.data!.products.length}'),
                        InfoWidget(
                            label: 'Order Date',
                            content:
                                '${cubit.getOrderDetailsModel!.data!.date}'),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => OrderProduct(
                          orderProduct:
                              cubit.getOrderDetailsModel!.data!.products[index],
                          quantity: cubit.getOrderDetailsModel!.data!
                              .products[index].quantity!,
                        ),
                        itemCount:
                            cubit.getOrderDetailsModel!.data!.products.length,
                      ),
                    ),
                    if (cubit.getOrderDetailsModel!.data!.status != 'Cancelled')
                      CustomButton(
                        title: 'Cancel order',
                        function: () {
                          cubit.cancelOrder(orderId: widget.orderId);
                        },
                      ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
