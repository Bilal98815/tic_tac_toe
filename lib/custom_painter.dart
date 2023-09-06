import 'package:flutter/material.dart';

void drawCross(
    Canvas canvas,
    Paint paint,
    double nonDiagonalStartX,
    double nonDiagonalStartY,
    double nonDiagonalEndX,
    double nonDiagonalEndY) {
  canvas.drawLine(Offset(nonDiagonalStartX, nonDiagonalStartY),
      Offset(nonDiagonalEndX, nonDiagonalEndY), paint);
}

class CrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5;


    double nonDiagonalStartX = 0;
    double nonDiagonalStartY = size.height;
    double nonDiagonalEndX = size.width;
    double nonDiagonalEndY = 0;

    drawCross(canvas, paint, nonDiagonalStartX,
        nonDiagonalStartY, nonDiagonalEndX, nonDiagonalEndY);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
