import 'package:flutter/material.dart';

import '../../../di/injection_container.dart';
import '../../../models/config.dart';

class NotchedBottomSheet extends StatelessWidget {
  final Widget image;
  final Widget? title;
  final Widget child;
  final Alignment notchAlignment;

  static const double headerImageBGSize = 94;
  static const double headerImageSize = 36;
  static const double headerHorizontalMargin = 24;

  const NotchedBottomSheet({
    super.key,
    required this.image,
    this.title,
    required this.child,
    this.notchAlignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          bottom: null,
          left: headerHorizontalMargin,
          right: headerHorizontalMargin,
          child: Align(
            alignment: notchAlignment,
            child: Container(
              width: headerImageBGSize,
              height: headerImageBGSize,
              decoration: BoxDecoration(
                color: sl<Config>().theme!.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(headerImageBGSize / 2),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: headerImageBGSize / 2),
          child: Material(
            color: sl<Config>().theme!.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.only(top: headerImageBGSize / 2),
              child: child,
            ),
          ),
        ),
        Positioned.fill(
          top: ((headerImageBGSize - headerImageSize) / 2) - 8.5,
          bottom: null,
          child: Align(
            alignment: notchAlignment,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: headerHorizontalMargin + ((headerImageBGSize - headerImageSize) / 2)),
              child: SizedBox(
                height: headerImageSize,
                width: headerImageSize,
                child: image,
              ),
            ),
          ),
        ),
        if (title != null)
          Positioned.fill(
            top: (headerImageBGSize / 2) + 15,
            bottom: null,
            child: Align(
              alignment: notchAlignment,
              child: title,
            ),
          ),
      ],
    );
  }
}
