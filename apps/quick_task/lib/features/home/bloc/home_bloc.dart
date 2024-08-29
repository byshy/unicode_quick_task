import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_task/core/enums/sync.dart';
import 'package:quick_task/di/injection_container.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/use_cases/home_use_case.dart';

import '../../../core/enums/base_status.dart';
import '../../../core/models/failures/failure.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TextEditingController todoTitleController = TextEditingController();
  final TextEditingController todoDescriptionController = TextEditingController();

  HomeBloc() : super(const HomeState()) {
    on<TODOAdded>(_onTODOAdded);
    on<TODOUpdated>(_onTODOUpdated);
  }

  void _onTODOAdded(TODOAdded event, Emitter<HomeState> emit) {
    Either<Failure, List<Todo>> result = sl<HomeUseCase>().addTodo(
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

  void _onTODOUpdated(TODOUpdated event, Emitter<HomeState> emit) {
    Either<Failure, List<Todo>> result = sl<HomeUseCase>().updateTodo(
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
}
