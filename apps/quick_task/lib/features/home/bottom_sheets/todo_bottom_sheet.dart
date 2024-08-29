import 'package:flutter/material.dart';
import 'package:picasso/widgets/bottom_sheets/flat_bottom_sheet/show_flat_bottom_sheet.dart';
import 'package:picasso/widgets/common/picasso_button.dart';
import 'package:picasso/widgets/common/picasso_text_field.dart';
import 'package:quick_task/generated/l10n.dart';
import 'package:quick_task/models/todo.dart';

Future<void> showTodoBottomSheet({Todo? todo}) async {
  await showFlatBottomSheet(
    child: SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          PicassoTextField(
            title: QuickTaskL10n.current.title,
            hint: QuickTaskL10n.current.title,
          ),
          const SizedBox(height: 8),
          PicassoTextField(
            title: QuickTaskL10n.current.description,
            hint: QuickTaskL10n.current.description,
            maxLines: null,
          ),
          const SizedBox(height: 8),
          PicassoButton(
            onPressed: () {},
            child: Text(
              todo == null ? QuickTaskL10n.current.add : QuickTaskL10n.current.edit,
            ),
          ),
        ],
      ),
    ),
  );
}
