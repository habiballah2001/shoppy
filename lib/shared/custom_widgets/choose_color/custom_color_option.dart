import 'package:flutter/material.dart';

import 'color_constant.dart';

class CustomColorOption extends StatelessWidget {
  final List<Color> colorsOptions;
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;
  const CustomColorOption({
    Key? key,
    required this.colorsOptions,
    required this.selectedColor,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              for (Color colors in colorsOptions)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7.5,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      /*if (onColorChanged == null) {
                        return;
                      }*/
                      onColorChanged(colors);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedColor == colors
                            ? ColorConstant.kBackgroundColor
                            : colors,
                        border: Border.all(
                          color: colors,
                          width: 2.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 15.0,
                        width: 15.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
