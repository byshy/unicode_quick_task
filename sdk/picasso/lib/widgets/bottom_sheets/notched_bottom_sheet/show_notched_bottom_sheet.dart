import 'package:flutter/material.dart';
import 'package:picasso/widgets/bottom_sheets/helpers/show_picasso_bottom_sheet.dart';

import 'notched_bottom_sheet.dart';

Future<T?> showNotchedBottomSheet<T>({
  required Widget image,
  Widget? title,
  required Function(BuildContext) child,
  Alignment notchAlignment = Alignment.center,
  bool useRootNavigator = false,
}) async {
  return showPicassoBottomSheet<T>(
    useRootNavigator: useRootNavigator,
    child: (context) => NotchedBottomSheet(
      image: image,
      title: title,
      notchAlignment: notchAlignment,
      child: child(context),
    ),
  );
}
