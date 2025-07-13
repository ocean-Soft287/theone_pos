import 'package:flutter/material.dart';

class DottedDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    const gap = 4.0;
    for (double i = 0; i < size.width; i += 10 + gap) {
      canvas.drawLine(Offset(i, 0), Offset(i + 5, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

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
