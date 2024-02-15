import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/components.dart';
import 'custom_button.dart';
import 'custom_texts.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final bool? showButton;
  final String? body;
  final String? img;
  final String? svg;
  final IconData? icon;
  final bool withExpanded;
  final Function()? buttonFunction;
  const EmptyWidget({
    super.key,
    required this.title,
    this.buttonText = 'Shop now',
    this.showButton = false,
    this.body,
    this.img,
    this.buttonFunction,
    this.svg,
    this.icon,
    this.withExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return withExpanded == true
        ? Expanded(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (img != null) Image.asset(img!),
                    if (svg != null)
                      SvgPicture.asset(
                        svg!,
                        height: 100,
                        width: 200,
                      ),
                    if (icon != null)
                      Icon(
                        icon,
                        size: 300,
                      ),
                    TitleMediumText(title),
                    if (body != null) BodyLargeText(body!),
                    if (showButton == true) ...[
                      const SpaceHeight(),
                      CustomButton(
                        function: buttonFunction,
                        title: buttonText,
                      )
                    ]
                  ],
                ),
              ),
            ),
          )
        : FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (img != null) Image.asset(img!),
                  if (svg != null)
                    SvgPicture.asset(
                      svg!,
                      height: 100,
                      width: 200,
                    ),
                  if (icon != null)
                    Icon(
                      icon,
                      size: 300,
                    ),
                  TitleLargeText(title),
                  if (body != null) BodyLargeText(body!),
                  if (showButton == true) ...[
                    const SpaceHeight(),
                    CustomButton(
                      function: buttonFunction,
                      title: buttonText,
                    )
                  ]
                ],
              ),
            ),
          );
  }
}
