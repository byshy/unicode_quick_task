import 'package:flutter/material.dart';
import 'package:picasso/models/extensions.dart';
import 'package:picasso/utils/gradients.dart';

class GeneralButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? height;
  final double? width;
  final BorderRadius? radius;
  final double elevation;
  final Color? bgColor;
  final Color disabledColor;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final Color? borderColor;
  final bool isHotKey;

  const GeneralButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.height = 48,
    this.width,
    this.radius,
    this.elevation = 8,
    this.bgColor,
    this.disabledColor = Colors.transparent,
    this.gradientBegin = Alignment.bottomLeft,
    this.gradientEnd = Alignment.topRight,
    this.borderColor,
    this.isHotKey = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius mRadius = radius ?? 12.0.toCircularRadius();

    return Material(
      color: disabledColor,
      shape: RoundedRectangleBorder(
        borderRadius: mRadius,
        side: BorderSide(color: disabledColor),
      ),
      elevation: elevation,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: mRadius,
          gradient: LinearGradient(
            begin: gradientBegin,
            end: gradientEnd,
            colors: Gradients.customer,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: mRadius,
          child: SizedBox(
            height: height,
            width: width,
            child: InkWell(
              onTap: onPressed,
              borderRadius: mRadius,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
