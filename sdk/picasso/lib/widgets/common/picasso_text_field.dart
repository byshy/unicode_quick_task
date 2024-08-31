import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../di/injection_container.dart';
import '../../models/config.dart';
import 'package:route_navigator/route_navigator.dart';

class PicassoTextField extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final FocusNode? focusNode;
  final bool autofocus;
  final String hint;
  final Widget? bottom;
  final TextEditingController? controller;
  final Widget? requiredIndicator;
  final bool isRequired;
  final bool obscureText;
  final int? maxLines;
  final double radius;
  final Color? fillColor;
  final TextAlign textAlign;
  final VoidCallback? onEditingComplete;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final bool? enabledTextField;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? containerPadding;
  final void Function()? onTap;
  final List<KeyboardActionsItem>? actions;
  final Decoration? decoration;
  final TextStyle? textFieldStyle;

  const PicassoTextField({
    Key? key,
    required this.title,
    this.titleStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
    ),
    this.focusNode,
    this.autofocus = false,
    required this.hint,
    this.bottom,
    this.controller,
    this.isRequired = false,
    this.requiredIndicator,
    this.obscureText = false,
    this.maxLines = 1,
    this.radius = 6,
    this.fillColor,
    this.textAlign = TextAlign.start,
    this.onEditingComplete,
    this.textAlignVertical,
    this.textDirection,
    this.textInputAction,
    this.keyboardType,
    this.hintStyle,
    this.enabledTextField,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.contentPadding,
    this.containerPadding,
    this.onTap,
    this.actions,
    this.decoration,
    this.textFieldStyle,
  }) : super(key: key);

  KeyboardActionsConfig buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: actions,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: containerPadding,
          decoration: decoration ?? BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: fillColor ?? sl<Config>().theme!.grey,
            border: Border.all(
              color: sl<Config>().theme!.grey,
              width: 1,
            ),
          ),
          child: Directionality(
            textDirection: textDirection ?? Directionality.of(context),
            child: TextField(
              style: textFieldStyle,
              enabled: enabledTextField ?? true,
              controller: controller,
              focusNode: focusNode,
              autofocus: autofocus,
              onEditingComplete: onEditingComplete,
              textInputAction: textInputAction,
              maxLines: maxLines,
              obscureText: obscureText,
              textAlign: textAlign,
              keyboardType: keyboardType,
              onTap: onTap,
              textAlignVertical: textAlignVertical,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: contentPadding ??
                    const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 0,
                    ),
                hintText: hint,
                hintStyle: hintStyle ??
                    const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                prefixIconConstraints: prefixIconConstraints,
                suffixIconConstraints: suffixIconConstraints,
              ),
            ),
          ),
        ),
        if (bottom != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),
              bottom!,
            ],
          ),
      ],
    );

    if (actions != null) {
      return KeyboardActions(
        config: buildConfig(sl<RouteNavigator>().getContext()),
        autoScroll: false,
        bottomAvoiderScrollPhysics: const NeverScrollableScrollPhysics(),
        child: child,
      );
    }

    return child;
  }
}
