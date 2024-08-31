import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_cluster/firestore_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage/exports.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:needle/needle.dart';
import 'package:quick_task/core/bloc/core_bloc.dart';
import 'package:quick_task/core/enums/completion.dart';
import 'package:quick_task/core/enums/hive_data_id.dart';
import 'package:quick_task/core/models/failures/failure.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/repos/home_repo.dart';

import 'home_repo_test.mocks.dart';

@GenerateMocks([
  Box,
  FireStoreService,
  CoreBloc,
])
void main() {
  final GetIt instance = GetIt.instance;

  late HomeRepo homeRepo;
  late MockBox mockBox;
  late MockFireStoreService mockFireStoreService;
  late MockCoreBloc mockCoreBloc;

  setUp(() {
    mockBox = MockBox();
    mockFireStoreService = MockFireStoreService();
    mockCoreBloc = MockCoreBloc();

    if (!instance.isRegistered<Box>()) {
      instance.registerSingleton<Box>(mockBox);
    }

    if (!instance.isRegistered<FireStoreService>()) {
      instance.registerSingleton<FireStoreService>(mockFireStoreService);
    }

    if (!instance.isRegistered<CoreBloc>()) {
      instance.registerSingleton<CoreBloc>(mockCoreBloc);
    }

    homeRepo = HomeRepo();
  });

  tearDown(() {
    if (instance.isRegistered<Box>()) {
      instance.unregister<Box>();
    }

    if (instance.isRegistered<FireStoreService>()) {
      instance.unregister<FireStoreService>();
    }

    if (instance.isRegistered<CoreBloc>()) {
      instance.unregister<CoreBloc>();
    }
  });

  group('HomeRepo', () {
    test('getTODOsFromLocal returns Right with list of TODOs on success', () {
      // Arrange
      final todosList = [
        const Todo(
          id: '1',
          title: 'Test Todo',
          description: null,
          completion: Completion.initial,
        ),
      ];
      when(mockBox.get(HiveDataID.todos)).thenReturn({
        'data': [todosList[0].toJson()]
      });

      // Act
      final Either<Failure, List<Todo>> result = homeRepo.getTODOsFromLocal();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected Right'),
        (todos) {
          final listEquality = const DeepCollectionEquality().equals;
          expect(listEquality(todos, todosList), true);
        },
      );
    });

    test('getTODOsFromLocal returns Left with UnknownFailure on exception', () {
      // Arrange
      when(mockBox.get(HiveDataID.todos)).thenThrow(Exception('Test Exception'));

      // Act
      final result = homeRepo.getTODOsFromLocal();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<UnknownFailure>());
        },
        (todosList) {},
      );
    });

    test('saveTodo returns Right on success', () {
      // Arrange
      final todosList = [
        const Todo(
          id: '1',
          title: 'Test Todo',
          description: null,
          completion: Completion.initial,
        ),
      ];

      when(mockBox.put(HiveDataID.todos, any)).thenAnswer((_) => Future.value());

      // Act
      final result = homeRepo.saveTodo(todos: todosList);

      // Assert
      expect(result, const Right<Failure, void>(null));
    });

    test('saveTodo returns Left with UnknownFailure on exception', () {
      // Arrange
      when(mockBox.put(HiveDataID.todos, any)).thenThrow(Exception('Test Exception'));

      // Act
      final result = homeRepo.saveTodo(todos: []);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<UnknownFailure>());
        },
        (value) {},
      );
    });
  });
}
