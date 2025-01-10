import 'package:flutter/material.dart';

import 'core_shape_skeleton.dart';

class CoreTextSkeleton extends StatelessWidget {
  const CoreTextSkeleton({
    super.key,
    this.color = black04,
    required this.fontSize,
    required this.width,
  })  : multiLines = false,
        lines = null;

  const CoreTextSkeleton.multiline({
    super.key,
    this.color = black04,
    required this.fontSize,
    required this.lines,
    this.width,
  }) :
        multiLines = true;

  final double fontSize;
  final double? width;
  final Color color;
  final bool multiLines;
  final int? lines;

  @override
  Widget build(BuildContext context) {
    if (multiLines == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(lines!, (index) {

          return Container(
            width: (width  ?? 0) * (lines == index + 1 ? 0.6 : 1),
            // width: MediaQuery.of(context).size.width * (lines == index ? 0.002 : 1),
            margin: EdgeInsets.symmetric(vertical: fontSize * 0.34),
            height: fontSize,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(fontSize * 0.6),
            ),
          );
        }),
      );
    }
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: fontSize * 0.4),
      height: fontSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(fontSize * 0.6),
      ),
    );
  }
}
