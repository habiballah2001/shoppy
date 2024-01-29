/*
import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? padding;
  final double? margin;
  const Skeleton({super.key, this.height, this.width, this.padding = 6, this.margin = 0});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.deepOrange.shade100,
      highlightColor: Colors.purple.shade100,
      child: Container(
        height: height,
        width: width,
        padding:  EdgeInsets.all(padding!),
        margin:  EdgeInsets.all(margin!),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5)
        ),
      ),
    );
  }
}
class CircleSkeleton extends StatelessWidget {
  final double? radius;

  const CircleSkeleton({super.key, this.radius,});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.deepOrange.shade100,
      highlightColor: Colors.purple.shade100,
      child: const CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 20,

      ),
    );
  }
}
*/
