import 'package:flutter/material.dart';
import 'dart:math';

class PieChartPainter extends CustomPainter {
  final double credits;
  final double debits;

  PieChartPainter({required this.credits, required this.debits});

  @override
  void paint(Canvas canvas, Size size) {
    double smallestDimension = min(size.width, size.height);
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: smallestDimension,
      height: smallestDimension,
    );
    final startAngle = -pi / 2;
    double creditAngle = (credits / (credits + debits)) * 2 * pi;
    double debitAngle = 2 * pi - creditAngle;

    final paint1 = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Draw credits
    canvas.drawArc(rect, startAngle, creditAngle, true, paint1);

    // Draw debits
    canvas.drawArc(rect, startAngle + creditAngle, debitAngle, true, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
