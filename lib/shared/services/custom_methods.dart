
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CustomMethods {
  static void popNavigate(BuildContext context) {
    return Navigator.canPop(context) ? Navigator.pop(context) : null;
  }

  static void navigateTo(
          {required Widget widget, required BuildContext context}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );

  static void navigateAndFinish(
          {required Widget widget, required BuildContext context}) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (route) => false,
      );

  static void snack(
      {required String content,
      int duration = 1000,
      required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: duration),
      ),
    );
  }

  static Future<bool?> toast(
      {required String body, Color color = Colors.green}) {
    return Fluttertoast.showToast(
      msg: body,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 18,
      backgroundColor: color,
    );
  }

  static String? validator(
      {required String value, required String returnedString}) {
    if (value.isEmpty) {
      return returnedString;
    }
    return null;
  }
}
