import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/app_cubit/shop_cubit.dart';
import '../../controller/app_cubit/shop_states.dart';
import '../../shared/custom_widgets/custom_texts.dart';
import '../../widgets/orders/order_product.dart';

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
        appBar: AppBar(
          title: const TitleLargeText('Order Details'),
        ),
        body: state is! LoadingGetOrderDetailsState ||
                cubit.getOrderDetailsModel != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const TitleMediumText(
                              'Total : ',
                            ),
                            const Spacer(),
                            TitleLargeText(
                              '${cubit.getOrderDetailsModel!.data!.total} EGP ',
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const TitleMediumText(
                              'Products : ',
                            ),
                            const Spacer(),
                            TitleLargeText(
                              '${cubit.getOrderDetailsModel!.data!.products.length} ',
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const TitleMediumText(
                              'Order Date : ',
                            ),
                            const Spacer(),
                            TitleLargeText(
                              '${cubit.getOrderDetailsModel!.data!.date} ',
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => OrderProduct(
                          orderProduct:
                              cubit.getOrderDetailsModel!.data!.products[index],
                        ),
                        itemCount:
                            cubit.getOrderDetailsModel!.data!.products.length,
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
