import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_container.dart';

class CustomCachedImage extends StatelessWidget {
  final String img;
  final String errorImg;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit? fit;
  const CustomCachedImage({
    super.key,
    required this.img,
    this.errorImg = '',
    this.height,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      radius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: img,
        height: height,
        width: width,
        fit: fit,
        progressIndicatorBuilder: (context, url, progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(
          child: SvgPicture.asset(
            errorImg,
          ),
        ),
      ),
    );
  }
}
