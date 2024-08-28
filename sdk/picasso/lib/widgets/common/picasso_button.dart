import 'package:flutter/material.dart';

import 'general_button.dart';

class PicassoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final double height;
  final double? width;
  final BorderRadius? radius;
  final double elevation;
  final bool isHotkey;

  const PicassoButton({
    super.key,
    this.onPressed,
    required this.child,
    this.gradientBegin = Alignment.bottomLeft,
    this.gradientEnd = Alignment.topRight,
    this.height = 48,
    this.width,
    this.radius,
    this.elevation = 8,
    this.isHotkey = false,
  });

  @override
  Widget build(BuildContext context) {
    return GeneralButton(
      onPressed: onPressed,
      height: height,
      width: width,
      radius: radius,
      elevation: elevation,
      isHotKey: isHotkey,
      child: child,
    );
  }
}
