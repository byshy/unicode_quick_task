import 'package:flutter/material.dart';
import 'package:picasso/models/config.dart';
import 'package:picasso/models/text_styles.dart';
import 'package:picasso/widgets/bottom_sheets/flat_bottom_sheet/show_flat_bottom_sheet.dart';
import 'package:picasso/widgets/common/picasso_button.dart';
import 'package:picasso/widgets/common/picasso_text_field.dart';
import 'package:picasso/widgets/common/picasso_text_form_field.dart';
import 'package:quick_task/features/home/bloc/home_bloc.dart';
import 'package:quick_task/generated/l10n.dart';
import 'package:quick_task/models/todo.dart';
import 'package:route_navigator/route_navigator.dart';

import '../../../di/injection_container.dart';

Future<void> showTodoBottomSheet({Todo? todo}) async {
  bool isNewTODO = todo == null;

  if (!isNewTODO) {
    sl<HomeBloc>().todoTitleController.text = todo.title;
    sl<HomeBloc>().todoDescriptionController.text = todo.description ?? '';
  }

  await showFlatBottomSheet(
    child: SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Form(
        key: sl<HomeBloc>().todoAdditionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isNewTODO ? QuickTaskL10n.current.add_todo : QuickTaskL10n.current.edit_todo,
              style: HeadingStyle.titleNormal,
            ),
            const SizedBox(height: 8),
            PicassoTextFormField(
              key: const ValueKey('todo_title_field'),
              autofocus: true,
              controller: sl<HomeBloc>().todoTitleController,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              validator: (title) {
                if (title?.trim().isEmpty ?? true) {
                  return QuickTaskL10n.current.required_field;
                }

                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: sl<Config>().theme!.grey,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                labelText: QuickTaskL10n.current.title,
                hintText: QuickTaskL10n.current.title,
              ),
            ),
            const SizedBox(height: 8),
            PicassoTextField(
              key: const ValueKey('todo_description_field'),
              controller: sl<HomeBloc>().todoDescriptionController,
              title: '${QuickTaskL10n.current.description} (${QuickTaskL10n.current.optional})',
              hint: '${QuickTaskL10n.current.description} (${QuickTaskL10n.current.optional})',
              maxLines: null,
            ),
            const SizedBox(height: 8),
            PicassoButton(
              key: const ValueKey('add_todo_button'),
              onPressed: () async {
                if (!sl<HomeBloc>().todoAdditionFormKey.currentState!.validate()) return;

                await sl<RouteNavigator>().pop();

                String title = sl<HomeBloc>().todoTitleController.text;
                String description = sl<HomeBloc>().todoDescriptionController.text;

                if (isNewTODO) {
                  sl<HomeBloc>().add(
                    TODOAdded(
                      todo: Todo(
                        id: '${DateTime.now().millisecondsSinceEpoch}',
                        title: title,
                        description: description,
                      ),
                    ),
                  );
                } else {
                  sl<HomeBloc>().add(
                    TODOUpdated(
                      todo: todo.copyWith(
                        title: title,
                        description: description,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                isNewTODO ? QuickTaskL10n.current.add : QuickTaskL10n.current.edit,
                style: PicassoButtonStyle.buttonNormal.copyWith(
                  color: sl<Config>().theme!.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
