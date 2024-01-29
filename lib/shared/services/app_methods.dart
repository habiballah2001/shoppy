import 'dart:developer';

import '../../modules/login&register/login_screen.dart';
import '../data_source/local/cache_helper.dart';
import 'custom_methods.dart';

class AppMethods {
  static void signOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        CustomMethods.navigateAndFinish(
          widget: const LoginScreen(),
          context: context,
        );
      }
    }).catchError((e) {
      log('err in logout $e');
    });
  }
}
