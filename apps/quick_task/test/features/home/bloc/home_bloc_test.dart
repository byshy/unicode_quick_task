import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:needle/needle.dart';
import 'package:quick_task/core/enums/completion.dart';
import 'package:quick_task/core/models/failures/failure.dart';
import 'package:quick_task/features/home/bloc/home_bloc.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/use_cases/home_use_case.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([
  HomeUseCase,
])
void main() {
  group('Home Bloc base flow (all customers).', () {
    final List<Todo> todos = [
      const Todo(
        id: '1',
        title: 'Test Todo',
        completion: Completion.initial,
      ),
    ];

    final GetIt instance = GetIt.instance;

    late HomeBloc homeBloc;
    late MockHomeUseCase mockHomeUseCase;

    setUp(() {
      homeBloc = HomeBloc();
      mockHomeUseCase = MockHomeUseCase();

      if (!instance.isRegistered<HomeBloc>()) {
        instance.registerSingleton<HomeBloc>(homeBloc);
      }

      if (!instance.isRegistered<HomeUseCase>()) {
        instance.registerSingleton<HomeUseCase>(mockHomeUseCase);
      }

      when(mockHomeUseCase.getTODOsFromLocal()).thenReturn(const Right([]));
    });

    tearDown(() {
      if (instance.isRegistered<HomeUseCase>()) {
        instance.unregister<HomeUseCase>();
      }

      homeBloc.close();
    });

    test("Init state is correct.", () {
      expect(
        instance<HomeBloc>().state,
        const HomeState(),
      );
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomeState] with updated todosList when TODOLoaded is added',
      build: () {
        when(mockHomeUseCase.getTODOsFromLocal()).thenReturn(Right(todos));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const TODOLoaded()),
      expect: () => [
        HomeState(todosList: todos),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits nothing when TODOLoaded fails',
      build: () {
        when(mockHomeUseCase.getTODOsFromLocal()).thenReturn(Left(UnknownFailure()));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const TODOLoaded()),
      expect: () => [],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeState] with updated todosList when TODOAdded is successful',
      build: () {
        when(mockHomeUseCase.addTodo(
          todosList: anyNamed('todosList'),
          todo: anyNamed('todo'),
        )).thenAnswer((_) async => Right(todos));

        return homeBloc;
      },
      act: (bloc) => bloc.add(TODOAdded(todo: todos.first)),
      expect: () => [
        HomeState(todosList: todos),
      ],
      verify: (_) {
        verify(mockHomeUseCase.resetTODOFields()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeState] with updated todosList when TODOUpdated is successful',
      build: () {
        when(mockHomeUseCase.updateTodo(
          todosList: anyNamed('todosList'),
          todo: anyNamed('todo'),
        )).thenAnswer((_) async => Right(todos));

        return homeBloc;
      },
      act: (bloc) => bloc.add(TODOUpdated(todo: todos.first)),
      expect: () => [
        HomeState(todosList: todos),
      ],
      verify: (_) {
        verify(mockHomeUseCase.resetTODOFields()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeState] with updated todosList when TODODeleted is successful',
      build: () {
        when(mockHomeUseCase.deleteTodo(
          todosList: anyNamed('todosList'),
          todo: anyNamed('todo'),
        )).thenAnswer((_) async => Right(todos));

        return homeBloc;
      },
      act: (bloc) => bloc.add(TODODeleted(todo: todos.first)),
      expect: () => [
        HomeState(todosList: todos),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'calls syncTODOsWithRemote when SyncTODOsWithRemote is added',
      build: () {
        when(mockHomeUseCase.syncTODOsWithRemote()).thenAnswer((_) async => const Right(null));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const SyncTODOsWithRemote()),
      verify: (_) {
        verify(mockHomeUseCase.syncTODOsWithRemote()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeState] with updated todosList when FirstTimeTODOLoaded is successful',
      build: () {
        when(mockHomeUseCase.getTODOsFromFirebase()).thenAnswer((_) async => Right(todos));

        return homeBloc;
      },
      act: (bloc) => bloc.add(const FirstTimeTODOLoaded()),
      expect: () => [
        HomeState(todosList: todos),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits nothing when FirstTimeTODOLoaded fails',
      build: () {
        when(mockHomeUseCase.getTODOsFromFirebase()).thenAnswer((_) async => Left(UnknownFailure()));

        return homeBloc;
      },
      act: (bloc) => bloc.add(const FirstTimeTODOLoaded()),
      expect: () => [],
    );
  });
}
