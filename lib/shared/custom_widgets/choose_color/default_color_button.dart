import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class DefaultColorButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? background;
  final bool isUpperCase = true;
  final double? radius;
  final Function() function;
  final String text;
  const DefaultColorButton({
    Key? key,
    this.width,
    this.height,
    this.background = primaryColor,
    this.radius = 10,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radius!,
          ),
          color: background,
        ),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
