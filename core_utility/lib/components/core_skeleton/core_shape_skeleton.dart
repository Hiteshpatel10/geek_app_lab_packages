import 'package:flutter/material.dart';

const black04 = Color(0x0A1D1D1D);

class CoreShapeSkeleton extends StatelessWidget {
  const CoreShapeSkeleton({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 8,
    this.color = black04,
    this.padding,
  }) : radius = null;

  const CoreShapeSkeleton.circle({
    super.key,
    this.radius,
    this.borderRadius = 8,
    this.color = black04,
    this.padding,
  })  : height = radius,
        width = radius;

  final double? height;
  final double? width;
  final double borderRadius;
  final Color color;
  final EdgeInsets? padding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            radius != null ? BorderRadius.circular(radius!) : BorderRadius.circular(borderRadius),
      ),
    );
  }
}
