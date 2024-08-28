import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'package:route_navigator/route_navigator.dart';

import '../../di/injection_container.dart';

class PicassoTextFormField extends StatelessWidget {
  final TextStyle? style;
  final FocusNode? focusNode;
  final Widget? bottom;
  final TextEditingController? controller;
  final AutovalidateMode? autoValidateMode;
  final FormFieldValidator<String>? validator;
  final InputDecoration? decoration;
  final Widget? requiredIndicator;
  final bool isRequired;
  final bool obscureText;
  final int? maxLines;
  final double radius;
  final Color? fillColor;
  final String obscuringCharacter;
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
  final ValueChanged<String>? onChanged;
  final List<KeyboardActionsItem>? actions;
  final void Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;

  const PicassoTextFormField({
    Key? key,
    this.style,
    this.focusNode,
    this.autoValidateMode,
    this.decoration,
    this.validator,
    this.obscuringCharacter = '•',
    this.onChanged,
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
    this.onFieldSubmitted,
    this.onTapOutside,
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
        TextFormField(
          enabled: enabledTextField ?? true,
          controller: controller,
          autovalidateMode: autoValidateMode,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          textInputAction: textInputAction,
          maxLines: maxLines,
          obscureText: obscureText,
          textAlign: textAlign,
          keyboardType: keyboardType,
          onTap: onTap,
          textAlignVertical: textAlignVertical,
          decoration: decoration,
          validator: validator,
          obscuringCharacter: obscuringCharacter,
          style: style,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onTapOutside: onTapOutside,
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
