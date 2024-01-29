import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/controller/app_cubit/shop_cubit.dart';
import 'package:shoppy/controller/app_cubit/shop_states.dart';
import 'package:shoppy/modules/setting/faqs_screen.dart';
import 'package:shoppy/shared/custom_widgets/custom_container.dart';
import 'package:shoppy/shared/data_source/local/cache_helper.dart';
import 'package:shoppy/shared/services/app_methods.dart';
import '../../shared/components/components.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_list_tile.dart';
import '../../shared/custom_widgets/custom_texts.dart';
import '../../shared/services/custom_methods.dart';
import '../../shared/services/dialogs.dart';
import '../orders/orders_screen.dart';
import 'profile/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return CustomContainer(
          margin: const EdgeInsets.all(10),
          color: Theme.of(context).cardColor,
          radius: BorderRadius.circular(20),
          child: Column(
            children: [
              CustomListTile(
                leadingIcon: Icons.shopping_bag_outlined,
                title: 'Orders',
                function: () {
                  CustomMethods.navigateTo(
                    widget: const OrdersScreen(),
                    context: context,
                  );
                },
              ),
              CustomListTile(
                leadingIcon: Icons.person_2_outlined,
                title: 'Profile',
                function: () {
                  CustomMethods.navigateTo(
                    widget: const ProfileScreen(),
                    context: context,
                  );
                },
              ),
              CustomListTile(
                leadingIcon: Icons.info_outline,
                title: 'FAQs',
                divider: false,
                function: () {
                  CustomMethods.navigateTo(
                    widget: const FAQsScreen(),
                    context: context,
                  );
                },
              ),
              const TitleMediumText('theme'),
              const SpaceHeight(),
              SwitchListTile(
                title: cubit.isDark
                    ? const TitleMediumText('dark')
                    : const TitleMediumText('light'),
                value: cubit.isDark,
                onChanged: (value) {
                  cubit.changeMode(shared: value);
                },
              ),
              const Spacer(),
              CustomButton(
                width: double.infinity,
                background: Colors.deepOrange,
                radius: 30,
                function: () {
                  Dialogs.logOutDialog(
                    content: 'logout?!',
                    function: () {
                      AppMethods.signOut(context);
                    },
                    context: context,
                  );
                },
                title: 'Sign Out',
                icon: Icons.logout,
              ),
            ],
          ),
        );
      },
    );
  }
}
