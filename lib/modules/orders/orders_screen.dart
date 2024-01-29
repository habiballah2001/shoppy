import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/app_cubit/shop_cubit.dart';
import '../../controller/app_cubit/shop_states.dart';
import '../../widgets/orders/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    AppCubit.get(context).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
        ),
        body: state is! LoadingGetOrdersState
            ? ListView.separated(
                itemBuilder: (context, index) => OrderItem(
                  orderInfo: cubit.getOrderModel!.orderList!.orderInfo[index],
                ),
                itemCount: cubit.getOrderModel!.orderList!.orderInfo.length,
                scrollDirection: Axis.vertical,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
