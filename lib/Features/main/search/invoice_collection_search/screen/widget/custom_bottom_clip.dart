import 'package:flutter/material.dart';
import 'dart:math';

class BottomScallopClipper extends CustomClipper<Path> {
  final int scallopCount;
  final double scallopRadius;

  /// [scallopCount]: how many semi-circles you want across the width
  /// [scallopRadius]: the radius of each semi-circle
  BottomScallopClipper({this.scallopCount = 12, this.scallopRadius = 8.0});

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double height = size.height;
    final double width = size.width;

    // 1) move to top-left
    path.moveTo(0, 0);

    // 2) down to (0, height - scallopRadius)
    path.lineTo(0, height - scallopRadius);

    // 3) draw scallops
    final double step = width / scallopCount;
    for (int i = 0; i < scallopCount; i++) {
      final double centerX = step * i + step / 2;
      final Rect circleRect = Rect.fromCircle(
        center: Offset(centerX, height - scallopRadius),
        radius: scallopRadius,
      );
      // we start at π (180°) and sweep -π (−180°) to cut the top half out
      path.arcTo(circleRect, pi, -pi, false);
    }

    // 4) line up to top right, then close
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
