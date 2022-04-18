import 'package:flutter/material.dart';

class PointedLinePainter extends CustomPainter {
  final double width;

  PointedLinePainter(this.width);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(width / 3, 0.5, width, 0);
    path.quadraticBezierTo(width / 3, -0.5, 0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
