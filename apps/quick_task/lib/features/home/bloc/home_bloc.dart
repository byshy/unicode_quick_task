import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picasso/exports.dart';
import 'package:quick_task/core/enums/sync.dart';
import 'package:quick_task/di/injection_container.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/use_cases/home_use_case.dart';

import '../../../core/enums/base_status.dart';
import '../../../core/models/failures/failure.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GlobalKey<FormState> todoAdditionFormKey = GlobalKey<FormState>();

  final ConfettiController controllerCenter = ConfettiController(
    duration: const Duration(seconds: 1),
  );

  final TextEditingController todoTitleController = TextEditingController();
  final TextEditingController todoDescriptionController = TextEditingController();

  HomeBloc() : super(const HomeState()) {
    on<FirstTimeTODOLoaded>(_onFirstTimeTODOLoaded);
    on<SyncTODOsWithRemote>(_onSyncTODOsWithRemote);
    on<TODOLoaded>(_onTODOLoaded);
    on<TODOAdded>(_onTODOAdded);
    on<TODOUpdated>(_onTODOUpdated);
    on<TODODeleted>(_onTODODeleted);

    add(const TODOLoaded());
  }

  Future<void> _onFirstTimeTODOLoaded(FirstTimeTODOLoaded event, Emitter<HomeState> emit) async {
    emit(state.copyWith(baseStatus: BaseStatus.loading));

    Either<Failure, List<Todo>> result = await sl<HomeUseCase>().getTODOsFromFirebase();

    await result.fold(
      (failure) {
        emit(state.copyWith(baseStatus: BaseStatus.failure));
      },
      (newTodosList) async {
        await _postSuccessTODOLoad(
          emit,
          todos: newTodosList,
        );
      },
    );
  }

  Future<void> _onSyncTODOsWithRemote(SyncTODOsWithRemote event, Emitter<HomeState> emit) async {
    await sl<HomeUseCase>().syncTODOsWithRemote();
  }

  Future<void> _onTODOLoaded(TODOLoaded event, Emitter<HomeState> emit) async {
    emit(state.copyWith(baseStatus: BaseStatus.loading));

    Either<Failure, List<Todo>> result = sl<HomeUseCase>().getTODOsFromLocal();

    await result.fold(
      (failure) {
        emit(state.copyWith(baseStatus: BaseStatus.failure));
      },
      (newTodosList) async {
        await _postSuccessTODOLoad(
          emit,
          todos: newTodosList,
        );
      },
    );
  }

  Future<void> _postSuccessTODOLoad(Emitter<HomeState> emit, {required List<Todo> todos}) async {
    emit(state.copyWith(
      baseStatus: BaseStatus.success,
      todosList: todos,
    ));

    await Future.delayed(const Duration(milliseconds: 400));

    emit(state.copyWith(
      firstRenderDone: true,
    ));
  }

  Future<void> _onTODOAdded(TODOAdded event, Emitter<HomeState> emit) async {
    Either<Failure, List<Todo>> result = await sl<HomeUseCase>().addTodo(
      todosList: state.todosList,
      todo: event.todo,
    );

    result.fold(
      (failure) {},
      (newTodosList) {
        emit(state.copyWith(todosList: newTodosList));
      },
    );

    sl<HomeUseCase>().resetTODOFields();
  }

  Future<void> _onTODOUpdated(TODOUpdated event, Emitter<HomeState> emit) async {
    Either<Failure, List<Todo>> result = await sl<HomeUseCase>().updateTodo(
      todosList: state.todosList,
      todo: event.todo,
    );

    result.fold(
      (failure) {},
      (newTodosList) {
        emit(state.copyWith(todosList: newTodosList));
      },
    );

    sl<HomeUseCase>().resetTODOFields();
  }

  Future<void> _onTODODeleted(TODODeleted event, Emitter<HomeState> emit) async {
    Either<Failure, List<Todo>> result = await sl<HomeUseCase>().deleteTodo(
      todosList: state.todosList,
      todo: event.todo,
    );

    result.fold(
      (failure) {},
      (newTodosList) {
        emit(state.copyWith(todosList: newTodosList));
      },
    );
  }
}
