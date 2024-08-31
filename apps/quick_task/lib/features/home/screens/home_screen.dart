import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage/local_storage.dart';
import 'package:picasso/models/config.dart';
import 'package:picasso/widgets/bottom_sheets/language_bottom_sheet.dart';
import 'package:quick_task/core/bloc/core_bloc.dart';
import 'package:quick_task/core/enums/config_names.dart';
import 'package:quick_task/core/enums/sync.dart';
import 'package:quick_task/features/home/bottom_sheets/todo_bottom_sheet.dart';
import 'package:quick_task/features/home/widgets/todo_item_slidable.dart';
import 'package:quick_task/generated/l10n.dart';
import 'package:quick_task/models/todo.dart';
import 'package:route_navigator/route_navigator.dart';
import 'package:unicode/enums/workmanager_tasks.dart';
import 'package:unicode/helpers/wm_task_register.dart';
import 'package:unicode/unicode.dart';

import '../../../di/injection_container.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    if (sl<Config>().workflow!.autoSync) {
      Workmanager().registerTask(
        BGTask.syncTODOs.uniqueName,
        BGTask.syncTODOs.taskName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreBloc, CoreState>(
      buildWhen: (previous, current) {
        return previous.lang != current.lang;
      },
      builder: (context, state) {
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => showLanguageBottomSheet(
                    selectedLanguage: sl<UnicodeStorage>().getString(BaseConfigs.lang) ?? '',
                    onLanguageChange: (value) {
                      sl<CoreBloc>().add(
                        CoreLanguageChanged(
                          language: value,
                        ),
                      );
                      sl<RouteNavigator>().pop();
                    },
                  ),
                  icon: const Icon(Icons.translate),
                ),
                title: Text(
                  QuickTaskL10n.current.home,
                ),
                actions: [
                  TextButton.icon(
                    onPressed: state.syncStatus.isSynced
                        ? null
                        : () {
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

                  return TodoItemSlidable(
                    key: ValueKey('todo_item_slidable_$index'),
                    index: index,
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
      },
    );
  }
}
