import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/components.dart';
import 'custom_methods.dart';
import '../material/custom_texts.dart';

class Dialogs {
  static void success({
    required BuildContext context,
  }) {
    showDialog(
        context: context,
        builder: (_) => const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Successful!"),
                ],
              ),
            ));
  }

  static void errorDialog({
    required String content,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.red.shade900,
              ),
              const SpaceWidth(),
              BodyLargeText(
                'Error!',
                color: Colors.red.shade900,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/error.svg'
                '',
                height: 60,
              ),
              const SpaceHeight(),
              BodyLargeText(
                content,
                color: Colors.red.shade900,
              )
            ],
          ),
        );
      },
    );
  }

  static void warningDialog({
    required String content,
    String acceptText = 'yes',
    Function()? accept,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/warning.svg'),
              BodyLargeText(content),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel'),
            ),
            if (accept != null)
              TextButton(
                onPressed: accept,
                child: Text(acceptText),
              ),
          ],
        );
      },
    );
  }

  static void logOutDialog({
    required String content,
    required Function() function,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.logout),
              SpaceWidth(),
              Text('log out'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/warning.svg',
                height: 60,
              ),
              BodyLargeText(content)
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Utils.popNavigate(context);
              },
              child: const Text('cancel'),
            ),
            TextButton(
              onPressed: function,
              child: const Text('log out'),
            ),
          ],
        );
      },
    );
  }

  static void pickPicDialog(
    context, {
    Function()? cameraTap,
    Function()? galleryTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const TitleMediumText(
            'Choose option',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      SpaceWidth(),
                      TitleSmallText('Camera')
                    ],
                  ),
                ),
              ),
              const SpaceHeight(),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SpaceWidth(),
                      TitleSmallText('Image')
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void imgDialog(
    context, {
    Function()? galleryTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const TitleMediumText(
            'Choose option',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => galleryTap,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SpaceWidth(),
                      TitleSmallText('Image')
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
