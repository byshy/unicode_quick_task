import 'package:flutter/material.dart';

class CurvedCorners extends StatelessWidget {
  final double radius;
  final Color color;

  const CurvedCorners({
    super.key,
    required this.radius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CornersPainter(
        radius: radius,
        color: color,
      ),
    );
  }
}

class CornersPainter extends CustomPainter {
  final Color color;
  final double radius;

  CornersPainter({
    required this.radius,
    this.color = Colors.blue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create a rounded rectangle path
    final rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );
    Path roundedRectPath = Path()..addRRect(rRect);

    final finalPath = Path.combine(
      PathOperation.difference,
      path,
      roundedRectPath,
    );

    canvas.drawPath(finalPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
