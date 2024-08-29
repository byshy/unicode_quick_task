import 'package:dartz/dartz.dart';
import 'package:quick_task/core/models/failures/failure.dart';
import 'package:quick_task/features/home/bloc/home_bloc.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/repos/home_repo.dart';

import '../di/injection_container.dart';

class HomeUseCase {
  Future<Either<Failure, List<Todo>>> getTODOsFromFirebase() async {
    return await sl<HomeRepo>().getTODOsFromFirebase();
  }

  Future<void> syncTODOsWithRemote() async {
    await sl<HomeRepo>().syncTODOsWithRemote();
  }

  Either<Failure, List<Todo>> loadTodos() {
    return sl<HomeRepo>().loadTodos();
  }

  Future<Either<Failure, List<Todo>>> addTodo({
    required List<Todo> todosList,
    required Todo todo,
  }) async {
    try {
      List<Todo> updatedTodosList = List.of(todosList);

      updatedTodosList.add(todo);

      sl<HomeRepo>().saveTodo(todos: updatedTodosList);

      await sl<HomeRepo>().addTODOToFirebase(todo: todo);

      return Right(updatedTodosList);
    } catch (e) {
      return Left(
        UnknownFailure(
          messageData: 'Unable to add new TODO to the list',
          data: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<Todo>>> updateTodo({
    required List<Todo> todosList,
    required Todo todo,
  }) async {
    try {
      int indexOfOldTODO = todosList.indexWhere((e) => e.id == todo.id);

      List<Todo> updatedTodosList = List.of(todosList);

      updatedTodosList.removeAt(indexOfOldTODO);
      updatedTodosList.insert(indexOfOldTODO, todo);

      sl<HomeRepo>().saveTodo(todos: updatedTodosList);

      await sl<HomeRepo>().addTODOToFirebase(todo: todo);

      return Right(updatedTodosList);
    } catch (e) {
      return Left(
        UnknownFailure(
          messageData: 'Unable to update the selected TODO',
          data: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<Todo>>> deleteTodo({
    required List<Todo> todosList,
    required Todo todo,
  }) async {
    try {
      int indexOfOldTODO = todosList.indexWhere((e) => e.id == todo.id);

      List<Todo> updatedTodosList = List.of(todosList);

      updatedTodosList.removeAt(indexOfOldTODO);

      sl<HomeRepo>().saveTodo(todos: updatedTodosList);

      await sl<HomeRepo>().deleteTODOToFirebase(todo: todo);

      return Right(updatedTodosList);
    } catch (e) {
      return Left(
        UnknownFailure(
          messageData: 'Unable to update the selected TODO',
          data: e,
        ),
      );
    }
  }

  void resetTODOFields() {
    sl<HomeBloc>().todoTitleController.clear();
    sl<HomeBloc>().todoDescriptionController.clear();
  }
}
