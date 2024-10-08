import 'package:flutter/material.dart';
import 'package:picasso/exports.dart';
import 'package:picasso/models/config.dart';
import 'package:quick_task/features/home/bloc/home_bloc.dart';
import 'package:quick_task/features/home/widgets/todo_item.dart';
import 'package:quick_task/generated/l10n.dart';
import 'package:quick_task/models/todo.dart';

import '../../../di/injection_container.dart';

class TodoItemSlidable extends StatelessWidget {
  final Todo todo;
  final int index;

  const TodoItemSlidable({
    super.key,
    required this.todo,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            key: const ValueKey('todo_deletion_button'),
            onPressed: (_) => sl<HomeBloc>().add(TODODeleted(todo: todo)),
            backgroundColor: sl<Config>().theme!.white,
            foregroundColor: sl<Config>().theme!.red,
            icon: Icons.delete,
            label: QuickTaskL10n.current.delete,
          ),
        ],
      ),
      child: TodoItem(
        todo: todo,
        index: index,
      ),
    );
  }
}
