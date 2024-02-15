import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shoppy/view/modules/login&register/login_screen.dart';
import 'package:shoppy/view/modules/on_boarding_screens/on_boarding.dart';
import 'controller/auth/auth_cubit.dart';
import 'res/components/components.dart';
import 'res/components/constants.dart';
import 'controller/app_cubit/shop_cubit.dart';
import 'controller/app_cubit/shop_states.dart';
import 'res/material/choose_color/color_option_cubit/color_selector_cubit.dart';
import 'res/data_source/local/cache_helper.dart';
import 'res/data_source/remote/dio_helper.dart';
import 'res/utils/observer.dart';
import 'res/styles/themes.dart';
import 'view/layout/shop_layout.dart';

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

  Stripe.publishableKey =
      "pk_test_51OjTyaCRgm5bcv4bjWiyw5hYHUahyLZB0iYWXdcIw9F5TggA7oB8jylrpYBF0WkXI9KKC6tJk3vP7iQok29gtBjU006hdGxEb6";

  await dotenv.load(fileName: "assets/.env");
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  await Stripe.instance.applySettings();
  ErrorWidget.builder = (FlutterErrorDetails details) => const ErrorScreen();

  Widget widget;
  bool isDark_ = CacheHelper.getData(key: 'isDark') ?? false;
  bool onBoard_ = CacheHelper.getData(key: 'onBoard') ?? false;
  Constants.token_ = CacheHelper.getData(key: 'token');

  log('onboard $onBoard_');
  log('token ${Constants.token_}');
  log('isDark $isDark_');

  if (onBoard_ == true) {
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
            ..getAddresses()
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
