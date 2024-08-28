import 'package:flutter/material.dart';
import '../helpers/show_picasso_bottom_sheet.dart';
import 'flat_bottom_sheet.dart';

Future<T?> showFlatBottomSheet<T>({required Widget child, bool? isDismissible}) async {
  return await showPicassoBottomSheet<T>(
    isDismissible: isDismissible,
    child: (_) => SingleChildScrollView(
      child: FlatBottomSheet(
        contentWidget: child,
        canClose: isDismissible,
      ),
    ),
  );
}
