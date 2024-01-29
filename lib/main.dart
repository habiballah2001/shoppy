import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/auth/auth_cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/login&register/login_screen.dart';
import 'modules/on_boarding_screens/on_boarding.dart';
import 'shared/components/components.dart';
import 'shared/components/constants.dart';
import 'controller/app_cubit/shop_cubit.dart';
import 'controller/app_cubit/shop_states.dart';
import 'shared/custom_widgets/choose_color/color_option_cubit/color_selector_cubit.dart';
import 'shared/data_source/local/cache_helper.dart';
import 'shared/data_source/remote/dio_helper.dart';
import 'shared/observer.dart';
import 'shared/styles/themes.dart';

Future<void> main() async {
  //to sure (all in main method is done)then(run app).
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  ErrorWidget.builder = (FlutterErrorDetails details) => const ErrorScreen();

  Widget widget;
  bool? isDark_ = CacheHelper.getData(key: 'isDark');
  bool? onBoard_ = CacheHelper.getData(key: 'onBoard');
  Constants.token_ = CacheHelper.getData(key: 'token');

  log('onboard $onBoard_');
  log('token ${Constants.token_}');
  log('isDark $isDark_');

  if (onBoard_ != null) {
    if (Constants.token_ != null) {
      widget = const AppLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark_,
    startWidget: widget,
  ));
}

class MyApp extends StatefulWidget {
  final bool? isDark;
  final Widget startWidget;

  const MyApp({Key? key, this.isDark, required this.startWidget})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getHomeData()
            ..getCartData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getOrders()
            ..fQSs()
            ..changeMode(shared: widget.isDark),
        ),
        BlocProvider(
          create: (context) => ColorSelectorCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit()..getUserData(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: widget.startWidget,
          );
        },
      ),
    );
  }
}
