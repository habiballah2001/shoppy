import 'package:flutter/material.dart';
import '../material/custom_texts.dart';

class WithShadow extends StatelessWidget {
  final Widget item;
  final double x;
  final double y;
  const WithShadow({
    super.key,
    required this.item,
    this.x = 80,
    this.y = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 140.0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 30,
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(x, y),
                bottomRight: Radius.elliptical(x, y),
                topLeft: Radius.elliptical(x, y),
                topRight: Radius.elliptical(x, y),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 16,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
          item,
        ],
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String label;
  final String content;
  const InfoWidget({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BodyLargeText('$label:'),
        const Spacer(),
        TitleMediumText(content),
      ],
    );
  }
}

class SpaceHeight extends StatelessWidget {
  const SpaceHeight({super.key, this.height = 10});

  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class SpaceWidth extends StatelessWidget {
  const SpaceWidth({super.key, this.width = 10});

  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class CenterWidget extends StatelessWidget {
  final String? title;
  final Widget? widget;
  const CenterWidget({
    super.key,
    this.title,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Center(
            child: widget ??
                HeadLargeText(
                  title!,
                ),
          ),
        ),
      ],
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: HeadMediumText(
          'Something went wrong',
          color: Colors.red,
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double leftSpace;
  final double rightSpace;
  const CustomDivider({
    super.key,
    this.leftSpace = 0,
    this.rightSpace = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftSpace, right: rightSpace),
      child: Container(
        color: Colors.grey,
        height: 1,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
