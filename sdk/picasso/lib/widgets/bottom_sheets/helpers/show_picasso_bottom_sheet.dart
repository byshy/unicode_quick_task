import 'package:flutter/material.dart';
import 'package:route_navigator/route_navigator.dart';

import '../../../di/injection_container.dart';

Future<T?> showPicassoBottomSheet<T>({
  required Function(BuildContext) child,
  bool? isDismissible,
  bool useRootNavigator = false,
}) async {
  return await showModalBottomSheet<T>(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: isDismissible ?? true,
    enableDrag: isDismissible ?? true,
    useRootNavigator: useRootNavigator,
    context: sl<RouteNavigator>().getContext(),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child(context),
      );
    },
  );
}
