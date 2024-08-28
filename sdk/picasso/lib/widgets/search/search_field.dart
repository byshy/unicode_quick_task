import 'package:flutter/material.dart';
import 'package:picasso/models/text_styles.dart';

import '../../di/injection_container.dart';
import '../../models/config.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Color? fillColor;
  final bool? hasEnabledBorder;

  const SearchField({
    super.key,
    this.controller,
    this.onChanged,
    required this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.fillColor,
    this.hasEnabledBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            BodyStyle.body2Light.copyWith(
              color: sl<Config>().theme!.grey,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hasEnabledBorder == null
              ? BorderSide.none
              : BorderSide(
                  color: sl<Config>().theme!.grey,
                ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hasEnabledBorder == null
              ? BorderSide.none
              : BorderSide(
                  color: sl<Config>().theme!.grey,
                ),
        ),
        filled: true,
        fillColor: fillColor ?? sl<Config>().theme!.grey,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        prefixIcon: prefixIcon ?? const Icon(Icons.search),
        suffixIcon: (controller?.text.isEmpty ?? true)
            ? null
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  controller?.text = '';
                  if (onChanged != null) {
                    onChanged!('');
                  }
                },
              ),
      ),
    );
  }
}
