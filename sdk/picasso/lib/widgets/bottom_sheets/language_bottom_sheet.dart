import 'package:flutter/material.dart';
import 'package:picasso/di/injection_container.dart';
import 'package:picasso/models/config.dart';
import 'package:picasso/widgets/bottom_sheets/notched_bottom_sheet/show_notched_bottom_sheet.dart';

void showLanguageBottomSheet({
  required void Function(String)? onLanguageChange,
  required String selectedLanguage,
}) {
  Color activeColor = sl<Config>().theme!.customerColor;

  showNotchedBottomSheet(
    image: const Icon(
      Icons.translate,
      size: 30,
    ),
    child: (_) => SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            activeColor: activeColor,
            title: const Text('العربية'),
            value: 'ar',
            groupValue: selectedLanguage,
            onChanged: (value) {
              onLanguageChange!(value ?? '');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          RadioListTile<String>(
            activeColor: activeColor,
            title: const Text('English'),
            value: 'en',
            groupValue: selectedLanguage,
            onChanged: (value) {
              onLanguageChange!(value ?? '');
            },
          ),
        ],
      ),
    ),
  );
}
