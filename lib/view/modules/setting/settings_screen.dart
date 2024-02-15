import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/controller/app_cubit/shop_cubit.dart';
import 'package:shoppy/controller/app_cubit/shop_states.dart';
import 'package:shoppy/controller/auth/auth_cubit.dart';
import 'package:shoppy/view/modules/setting/addresses_screen.dart';
import 'package:shoppy/view/modules/setting/complaints_screen.dart';
import 'package:shoppy/view/modules/setting/faqs_screen.dart';
import 'package:shoppy/res/material/custom_container.dart';
import '../../../res/material/custom_button.dart';
import '../../../res/material/custom_list_tile.dart';
import '../../../res/material/custom_texts.dart';
import '../../../res/utils/custom_methods.dart';
import '../../../res/utils/dialogs.dart';
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
                  Utils.navigateTo(
                    widget: const OrdersScreen(),
                    context: context,
                  );
                },
              ),
              CustomListTile(
                leadingIcon: Icons.person_2_outlined,
                title: 'Profile',
                function: () {
                  Utils.navigateTo(
                    widget: const ProfileScreen(),
                    context: context,
                  );
                },
              ),
              CustomListTile(
                leadingIcon: Icons.person_2_outlined,
                title: 'Addresses',
                function: () {
                  Utils.navigateTo(
                    widget: const AddressesScreen(),
                    context: context,
                  );
                },
              ),
              CustomListTile(
                leadingIcon: Icons.info_outline,
                title: 'FAQs',
                function: () {
                  Utils.navigateTo(
                    widget: const FAQsScreen(),
                    context: context,
                  );
                },
              ),
              CustomListTile(
                leadingIcon: Icons.headset_mic_outlined,
                title: 'For complaints',
                divider: false,
                function: () {
                  Utils.navigateTo(
                    widget: const ComplaintsScreen(),
                    context: context,
                  );
                },
              ),
              CustomListTile(
                leadingIcon: Icons.language,
                title: 'Language',
                divider: false,
                function: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const TitleSmallText('English'),
                              onTap: () {
                                cubit.changeLang(lang: 'en');
                              },
                              trailing: cubit.language == 'en'
                                  ? const Icon(Icons.check)
                                  : null,
                            ),
                            ListTile(
                              title: const TitleSmallText('العربية'),
                              onTap: () {
                                cubit.changeLang(lang: 'ar');
                              },
                              trailing: cubit.language == 'ar'
                                  ? const Icon(Icons.check)
                                  : null,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const TitleMediumText('theme'),
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
                      AuthCubit.get(context).signOut(context);
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
