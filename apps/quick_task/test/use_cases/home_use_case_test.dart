import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:needle/needle.dart';
import 'package:quick_task/core/enums/completion.dart';
import 'package:quick_task/core/models/failures/failure.dart';
import 'package:quick_task/features/home/bloc/home_bloc.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/repos/home_repo.dart';
import 'package:quick_task/use_cases/helpers/todo_sync_helper.dart';
import 'package:quick_task/use_cases/home_use_case.dart';

import 'home_use_case_test.mocks.dart';

@GenerateMocks([
  HomeRepo,
  HomeBloc,
  TodoSyncHelper,
])
void main() {
  late HomeUseCase homeUseCase;
  late MockHomeRepo mockHomeRepo;
  late MockTodoSyncHelper mockTodoSyncHelper;

  final GetIt instance = GetIt.instance;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    mockTodoSyncHelper = MockTodoSyncHelper();
    homeUseCase = HomeUseCase();

    if (!instance.isRegistered<HomeRepo>()) {
      instance.registerSingleton<HomeRepo>(mockHomeRepo);
    }

    if (!instance.isRegistered<TodoSyncHelper>()) {
      instance.registerSingleton<TodoSyncHelper>(mockTodoSyncHelper);
    }
  });

  tearDown(() {
    if (instance.isRegistered<HomeRepo>()) {
      instance.unregister<HomeRepo>();
    }

    if (instance.isRegistered<TodoSyncHelper>()) {
      instance.unregister<TodoSyncHelper>();
    }
  });

  group('HomeUseCase', () {
    final List<Todo> todos = [
      const Todo(
        id: '1',
        title: 'Test Todo',
        completion: Completion.initial,
      ),
    ];

    const Todo newTodo = Todo(
      id: '2',
      title: 'New Todo',
      completion: Completion.initial,
    );

    const Failure failure = UnknownFailure(messageData: 'Some failure');

    test('getTODOsFromFirebase returns Right with list of todos on success', () async {
      when(mockHomeRepo.getTODOsFromFirebase()).thenAnswer((_) async => Right(todos));

      final result = await homeUseCase.getTODOsFromFirebase();

      expect(result, Right(todos));
    });

    test('getTODOsFromFirebase returns Left with failure on error', () async {
      when(mockHomeRepo.getTODOsFromFirebase()).thenAnswer((_) async => const Left(failure));

      final result = await homeUseCase.getTODOsFromFirebase();

      expect(result, const Left(failure));
    });

    test('syncTODOsWithRemote calls syncRemoteWithLocal and addLocalTodosToRemote on success', () async {
      when(homeUseCase.getTODOsFromLocal()).thenReturn(Right(todos));
      when(homeUseCase.getTODOsFromFirebase()).thenAnswer((_) async => Right(todos));
      when(mockTodoSyncHelper.syncRemoteWithLocal(todos, todos)).thenAnswer((_) async => Future.value());
      when(mockTodoSyncHelper.addLocalTodosToRemote(todos, todos)).thenAnswer((_) async => Future.value());

      final result = await homeUseCase.syncTODOsWithRemote();

      expect(result, const Right(null));
      verify(mockTodoSyncHelper.syncRemoteWithLocal(any, any)).called(1);
      verify(mockTodoSyncHelper.addLocalTodosToRemote(any, any)).called(1);
    });

    test('syncTODOsWithRemote returns Left with failure on error', () async {
      when(homeUseCase.getTODOsFromLocal()).thenReturn(const Left(failure));
      final result = await homeUseCase.syncTODOsWithRemote();

      expect(result.isLeft(), true);
      result.fold(
        (left) => expect(left, isA<UnknownFailure>()),
        (_) => fail('Expected failure'),
      );
    });

    test('getTODOsFromLocal returns Right with list of todos on success', () {
      when(mockHomeRepo.getTODOsFromLocal()).thenReturn(Right(todos));

      final result = homeUseCase.getTODOsFromLocal();

      expect(result, Right(todos));
    });

    test('getTODOsFromLocal returns Left with failure on error', () {
      when(mockHomeRepo.getTODOsFromLocal()).thenReturn(const Left(failure));

      final result = homeUseCase.getTODOsFromLocal();

      expect(result, const Left(failure));
    });

    test('addTodo returns Right with updated list on success', () async {
      when(mockHomeRepo.addTODOToFirebase(todo: anyNamed('todo'))).thenAnswer((_) async => Future.value());
      when(mockHomeRepo.saveTodo(todos: anyNamed('todos'))).thenReturn(const Right(null));

      final Either<Failure, List<Todo>> result = await homeUseCase.addTodo(
        todosList: todos,
        todo: newTodo,
      );

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right'),
        (updatedTodosList) {
          final listEquality = const DeepCollectionEquality().equals;
          expect(listEquality(updatedTodosList, [...todos, newTodo]), true);
        },
      );
    });

    test('addTodo returns Left with failure on error', () async {
      when(mockHomeRepo.addTODOToFirebase(todo: anyNamed('todo'))).thenThrow(Exception());

      final result = await homeUseCase.addTodo(
        todosList: todos,
        todo: newTodo,
      );

      expect(result.isLeft(), true);
      result.fold(
        (left) => expect(left, isA<UnknownFailure>()),
        (_) => fail('Expected failure'),
      );
    });

    test('updateTodo returns Right with updated list on success', () async {
      when(mockHomeRepo.addTODOToFirebase(todo: anyNamed('todo'))).thenAnswer((_) async => Future.value());
      when(mockHomeRepo.saveTodo(todos: anyNamed('todos'))).thenReturn(const Right(null));

      final result = await homeUseCase.updateTodo(
        todosList: todos,
        todo: todos.first.copyWith(title: 'Updated Title'),
      );

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []), contains(todos.first.copyWith(title: 'Updated Title')));
    });

    test('updateTodo returns Left with failure on error', () async {
      when(mockHomeRepo.addTODOToFirebase(todo: anyNamed('todo'))).thenThrow(Exception());

      final result = await homeUseCase.updateTodo(
        todosList: todos,
        todo: todos.first.copyWith(title: 'Updated Title'),
      );

      expect(result.isLeft(), true);
      result.fold(
        (left) => expect(left, isA<UnknownFailure>()),
        (_) => fail('Expected failure'),
      );
    });

    test('deleteTodo returns Right with updated list on success', () async {
      when(mockHomeRepo.deleteTODOToFirebase(todo: anyNamed('todo'))).thenAnswer((_) async => Future.value());
      when(mockHomeRepo.saveTodo(todos: anyNamed('todos'))).thenReturn(const Right(null));

      final result = await homeUseCase.deleteTodo(
        todosList: todos,
        todo: todos.first,
      );

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []), isEmpty);
    });

    test('deleteTodo returns Left with failure on error', () async {
      when(mockHomeRepo.deleteTODOToFirebase(todo: anyNamed('todo'))).thenThrow(Exception());

      final result = await homeUseCase.deleteTodo(
        todosList: todos,
        todo: todos.first,
      );

      expect(result.isLeft(), true);
      result.fold(
        (left) => expect(left, isA<UnknownFailure>()),
        (_) => fail('Expected failure'),
      );
    });
  });
}
