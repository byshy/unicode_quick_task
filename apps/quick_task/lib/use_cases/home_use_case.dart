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
    Either<Failure, List<Todo>> localTodosResult = getTODOsFromLocal();
    Either<Failure, List<Todo>> remoteTodosResult = await getTODOsFromFirebase();

    if (localTodosResult.isRight() && remoteTodosResult.isRight()) {
      List<Todo> localTodos = (localTodosResult as Right).value;
      List<Todo> remoteTodos = (remoteTodosResult as Right).value;

      List<String> updatedRemoteTodos = [];

      for (Todo remoteTodo in remoteTodos) {
        Todo? matchingTodo;

        try {
          matchingTodo = localTodos.firstWhere((todo) => todo.id == remoteTodo.id);
        } catch (_) {}

        if (matchingTodo == null) {
          await sl<HomeRepo>().deleteTODOToFirebase(todo: remoteTodo);
        } else {
          if (remoteTodo != matchingTodo) {
            await sl<HomeRepo>().addTODOToFirebase(todo: matchingTodo);
          }
        }

        updatedRemoteTodos.add(remoteTodo.id);
      }

      localTodos.removeWhere((todo) => updatedRemoteTodos.contains(todo.id));

      for (Todo localTodo in localTodos) {
        await sl<HomeRepo>().addTODOToFirebase(todo: localTodo);
      }
    }
  }

  Either<Failure, List<Todo>> getTODOsFromLocal() {
    return sl<HomeRepo>().getTODOsFromLocal();
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
