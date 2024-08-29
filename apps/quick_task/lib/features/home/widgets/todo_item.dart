import 'package:flutter/material.dart';
import 'package:quick_task/core/enums/completion.dart';
import 'package:quick_task/features/home/bloc/home_bloc.dart';
import 'package:quick_task/features/home/bottom_sheets/todo_bottom_sheet.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/use_cases/home_use_case.dart';

import '../../../di/injection_container.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.completion.isDone,
        onChanged: (value) {
          Todo newTODO = todo.copyWith(completion: value! ? Completion.done : Completion.initial);

          sl<HomeBloc>().add(
            TODOUpdated(
              todo: newTODO,
            ),
          );
        },
      ),
      title: Text(todo.title),
      subtitle: todo.hasDescription
          ? Text(
              todo.description!,
              maxLines: 2,
            )
          : null,
      onTap: () async {
        await showTodoBottomSheet(todo: todo);

        sl<HomeUseCase>().resetTODOFields();
      },
    );
  }
}
