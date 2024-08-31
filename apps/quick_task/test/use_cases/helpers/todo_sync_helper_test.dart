import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_task/core/enums/completion.dart';
import 'package:quick_task/di/injection_container.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/repos/home_repo.dart';
import 'package:quick_task/use_cases/helpers/todo_sync_helper.dart';

import 'todo_sync_helper_test.mocks.dart';

@GenerateMocks([
  HomeRepo,
])
void main() {
  late MockHomeRepo mockHomeRepo;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    sl.registerFactory<HomeRepo>(() => mockHomeRepo);
  });

  tearDown(() {
    sl.reset();
  });

  group('TodoSyncHelper', () {
    const todo1 = Todo(
      id: '1',
      title: 'Todo 1',
      description: 'Description 1',
      completion: Completion.initial,
    );
    const todo2 = Todo(
      id: '2',
      title: 'Todo 2',
      description: 'Description 2',
      completion: Completion.done,
    );

    test('syncRemoteWithLocal deletes remote todo if no match is found in local', () async {
      final localTodos = [todo1];
      final remoteTodos = [todo2];

      await TodoSyncHelper().syncRemoteWithLocal(localTodos, remoteTodos);

      verify(mockHomeRepo.deleteTODOToFirebase(todo: todo2)).called(1);
      verifyNever(mockHomeRepo.addTODOToFirebase(todo: anyNamed('todo')));
    });

    test('syncRemoteWithLocal updates remote todo if match is found but differs in attributes', () async {
      final modifiedTodo2 = todo2.copyWith(description: 'Updated Description');
      final localTodos = [modifiedTodo2];
      final remoteTodos = [todo2];

      await TodoSyncHelper().syncRemoteWithLocal(localTodos, remoteTodos);

      verify(mockHomeRepo.addTODOToFirebase(todo: modifiedTodo2)).called(1);
      verifyNever(mockHomeRepo.deleteTODOToFirebase(todo: anyNamed('todo')));
    });

    test('syncRemoteWithLocal does not update or delete if remote todo matches local', () async {
      final localTodos = [todo2];
      final remoteTodos = [todo2];

      await TodoSyncHelper().syncRemoteWithLocal(localTodos, remoteTodos);

      verifyNever(mockHomeRepo.deleteTODOToFirebase(todo: anyNamed('todo')));
      verifyNever(mockHomeRepo.addTODOToFirebase(todo: anyNamed('todo')));
    });

    test('addLocalTodosToRemote adds local todos that are not in remote', () async {
      final localTodos = [todo1];
      final remoteTodos = [todo2];

      await TodoSyncHelper().addLocalTodosToRemote(localTodos, remoteTodos);

      verify(mockHomeRepo.addTODOToFirebase(todo: todo1)).called(1);
    });

    test('addLocalTodosToRemote does not add local todos that are already in remote', () async {
      final localTodos = [todo2];
      final remoteTodos = [todo2];

      await TodoSyncHelper().addLocalTodosToRemote(localTodos, remoteTodos);

      verifyNever(mockHomeRepo.addTODOToFirebase(todo: anyNamed('todo')));
    });

    test('findMatchingTodoById returns correct Todo if found', () {
      final todos = [todo1, todo2];

      final result = TodoSyncHelper().findMatchingTodoById(todos, '2');

      expect(result, equals(todo2));
    });

    test('findMatchingTodoById returns null if Todo is not found', () {
      final todos = [todo1];

      final result = TodoSyncHelper().findMatchingTodoById(todos, '2');

      expect(result, isNull);
    });

    test('isTodoInRemote returns true if todo is in remote', () {
      const localTodo = todo1;
      final remoteTodos = [todo1, todo2];

      final result = TodoSyncHelper().isTodoInRemote(localTodo, remoteTodos);

      expect(result, isTrue);
    });

    test('isTodoInRemote returns false if todo is not in remote', () {
      const localTodo = todo1;
      final remoteTodos = [todo2];

      final result = TodoSyncHelper().isTodoInRemote(localTodo, remoteTodos);

      expect(result, isFalse);
    });
  });
}
