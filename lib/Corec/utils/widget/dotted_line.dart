import 'package:flutter/material.dart';
import 'dotted_divider.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedDividerPainter(),
      child: Container(height: 1),
    );
  }
}
