import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final double? value;
  final double stroke;
  final double size;

  const LoadingIndicator({
    super.key,
    this.color,
    this.value,
    this.backgroundColor,
    this.stroke = 3,
    this.size = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: stroke,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
