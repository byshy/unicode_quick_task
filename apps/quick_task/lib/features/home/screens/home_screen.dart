import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_task/core/enums/sync.dart';
import 'package:quick_task/features/home/bottom_sheets/todo_bottom_sheet.dart';
import 'package:quick_task/features/home/widgets/todo_item.dart';
import 'package:quick_task/generated/l10n.dart';
import 'package:quick_task/models/todo.dart';

import '../../../di/injection_container.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              QuickTaskL10n.current.home,
            ),
            actions: [
              TextButton.icon(
                onPressed: state.syncStatus.isSynced ? null : () {
                  sl<HomeBloc>().add(const SyncTODOsWithRemote());
                },
                label: Text(state.syncStatus.title()),
                icon: Icon(state.syncStatus.isSynced ? Icons.cloud_done_rounded : Icons.cloud_upload),
              ),
            ],
          ),
          body: ListView.separated(
            itemCount: state.todosList.length,
            itemBuilder: (_, index) {
              final Todo todo = state.todosList[index];

              return TodoItem(
                todo: todo,
              );
            },
            separatorBuilder: (_, index) => const SizedBox(height: 8),
          ),
          floatingActionButton: const FloatingActionButton(
            onPressed: showTodoBottomSheet,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
