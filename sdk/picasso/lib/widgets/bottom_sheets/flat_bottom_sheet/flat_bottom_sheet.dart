import 'package:flutter/material.dart';
import 'package:route_navigator/route_navigator.dart';

import '../../../di/injection_container.dart';
import '../../../models/config.dart';

class FlatBottomSheet extends StatelessWidget {
  final Widget contentWidget;
  final bool? canClose;

  const FlatBottomSheet({
    super.key,
    required this.contentWidget,
    this.canClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (canClose ?? false)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 22),
                  child: InkWell(
                    onTap: () => sl<RouteNavigator>().pop(),
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.close,
                        color: sl<Config>().theme!.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          contentWidget,
        ],
      ),
    );
  }
}
