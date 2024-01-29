import 'package:flutter/material.dart';
import '../components/components.dart';
import 'custom_container.dart';
import 'custom_texts.dart';

class CustomListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final Widget? leadingImage;
  final IconData trailIcon;
  final double? iconSize;
  final String title;
  final Color? color;
  final Function() function;
  final bool divider;
  const CustomListTile({
    super.key,
    this.leadingIcon,
    this.leadingImage,
    this.trailIcon = Icons.arrow_forward_ios,
    this.iconSize = 28,
    required this.title,
    required this.function,
    this.color = Colors.transparent,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      function: function,
      color: color,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (leadingIcon != null)
                  Icon(
                    leadingIcon,
                    size: iconSize,
                  ),
                if (leadingImage != null) leadingImage!,
                const SpaceWidth(width: 20),
                TitleSmallText(
                  title,
                ),
                const Spacer(),
                Icon(
                  trailIcon,
                  size: 18,
                ),
              ],
            ),
          ),
          if (divider == true)
            const CustomDivider(
              leftSpace: 50,
            )
        ],
      ),
    );
  }
}
