import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/controller/app_cubit/shop_cubit.dart';
import 'package:shoppy/controller/app_cubit/shop_states.dart';
import 'package:shoppy/res/material/CustomAppBar.dart';
import 'package:shoppy/res/material/custom_button.dart';
import 'package:shoppy/res/material/custom_texts.dart';
import 'package:shoppy/view/widgets/address_item.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: const CustomAppBar(
            title: TitleMediumText('Addresses'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = cubit.addressModel!.data!.data[index];
                    return AddressItem(addressModel: item);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cubit.addressModel!.data!.data.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
