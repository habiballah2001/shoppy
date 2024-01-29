import 'package:flutter/material.dart';
import '../../models/orders/get_order_model.dart';
import '../../modules/orders/order_details_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/custom_widgets/custom_container.dart';
import '../../shared/services/custom_methods.dart';

class OrderItem extends StatelessWidget {
  final OrderInfoModel orderInfo;
  const OrderItem({
    Key? key,
    required this.orderInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomMethods.navigateTo(widget: OrderDetailsScreen(orderId: orderInfo.id!),context: context, );
      },
      child: CustomContainer(
        padding: 10,
        child: Column(
          children: [
            InfoWidget(label: 'Order Date', content: orderInfo.date.toString()),
            InfoWidget(
                label: 'Total', content: orderInfo.total!.toStringAsFixed(2)),
            InfoWidget(label: 'status', content: orderInfo.status.toString()),
          ],
        ),
      ),
    );
  }
}
