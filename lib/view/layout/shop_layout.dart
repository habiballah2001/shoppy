import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppy/controller/auth/auth_cubit.dart';
import 'package:shoppy/res/material/CustomAppBar.dart';
import '../../res/components/constants.dart';
import '../../controller/app_cubit/shop_cubit.dart';
import '../../controller/app_cubit/shop_states.dart';
import '../../res/material/custom_texts.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context)
      ..getHomeData()
      ..getCartData()
      ..getCategoriesData()
      ..getFavoritesData()
      ..getOrders()
      ..fQSs();
    AuthCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: CustomAppBar(
          bgColor: Theme.of(context).scaffoldBackgroundColor,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              'assets/images/logo.svg',
            ),
          ),
          title: HeadSmallText(
            Lists.titles[cubit.currentIndex],
          ),
        ),
        body: Lists.bottomScreens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          items: Lists.bottomItems(context: context),
          onTap: (value) => cubit.changeBottomNavBar(value),
          // type: ,
        ),
      ),
    );
  }
}
