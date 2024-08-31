import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_task/features/home/widgets/todo_item.dart';

class HomeScreenTest {
  late WidgetTester tester;

  HomeScreenTest(this.tester);

  final addTodoFAB = find.byKey(const ValueKey('add_todo_fab'));
  final todoTitleField = find.byKey(const ValueKey('todo_title_field'));
  final todoDescriptionField = find.byKey(const ValueKey('todo_description_field'));
  final addTodoButton = find.byKey(const ValueKey('add_todo_button'));
  final deleteTodoButton = find.byKey(const ValueKey('todo_deletion_button'));

  Future<void> addNewTODO(String title, String description) async {
    await tester.tap(addTodoFAB, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.enterText(todoTitleField, title);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.enterText(todoDescriptionField, description);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.tap(addTodoButton, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> updateTODO(String title, String description) async {
    final todoLocator = find.descendant(
      of: find.byType(TodoItem),
      matching: find.text(title),
    );

    await tester.tap(todoLocator, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.enterText(todoDescriptionField, description);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.tap(addTodoButton, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> deleteTODO(String title) async {
    final todoLocator = find.descendant(
      of: find.byType(TodoItem),
      matching: find.text(title),
    );

    await tester.drag(todoLocator, const Offset(-500, 0));
    await tester.pumpAndSettle();
    await tester.tap(deleteTodoButton, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<bool> isTodoPresent(String title) async {
    final todoLocator = find.descendant(
      of: find.byType(TodoItem),
      matching: find.text(title),
    );

    return tester.any(todoLocator);
  }

  Future<bool> isTodoUpdated(String description) async {
    final todoLocator = find.descendant(
      of: find.byType(TodoItem),
      matching: find.text(description),
    );

    return tester.any(todoLocator);
  }

  Future<bool> isTodoAbsent(String title) async {
    final todoLocator = find.descendant(
      of: find.byType(TodoItem),
      matching: find.text(title),
    );

    return !tester.any(todoLocator);
  }
}
