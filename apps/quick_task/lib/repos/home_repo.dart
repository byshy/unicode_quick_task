import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_cluster/exports.dart';
import 'package:firebase_cluster/firestore_service.dart';
import 'package:local_storage/exports.dart';
import 'package:quick_task/core/bloc/core_bloc.dart';
import 'package:quick_task/core/helpers/connectivity.dart';

import '../core/enums/hive_data_id.dart';
import '../core/models/failures/failure.dart';
import '../di/injection_container.dart';
import '../models/todo.dart';

class HomeRepo {
  Either<Failure, List<Todo>> loadTodos() {
    try {
      List<Todo> todosList = [];

      Map<dynamic, dynamic> todos = sl<Box>().get(
        HiveDataID.todos,
      );

      List todosRawList = todos['data'];

      for (Map todoRawMap in todosRawList) {
        todosList.add(Todo.fromJson(todoRawMap.map((k, v) => MapEntry<String, dynamic>(k, v))));
      }

      return Right(todosList);
    } catch (e) {
      return Left(
        UnknownFailure(
          messageData: 'Unable to load TODOs',
          data: e,
        ),
      );
    }
  }

  Future<void> syncTODOsWithRemote() async {
    Either<Failure, List<Todo>> localTodosResult = loadTodos();
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
          await deleteTODOToFirebase(todo: remoteTodo);
        } else {
          if (remoteTodo != matchingTodo) {
            await addTODOToFirebase(todo: matchingTodo);
          }
        }

        updatedRemoteTodos.add(remoteTodo.id);
      }

      localTodos.removeWhere((todo) => updatedRemoteTodos.contains(todo.id));

      for (Todo localTodo in localTodos) {
        await addTODOToFirebase(todo: localTodo);
      }
    }
  }

  Either<Failure, void> saveTodo({required List<Todo> todos}) {
    try {
      sl<Box>().put(
        HiveDataID.todos,
        {
          'data': todos.map((e) => e.toJson()).toList(),
        },
      );

      return const Right(null);
    } catch (e) {
      return Left(
        UnknownFailure(
          messageData: 'Unable to save TODOs',
          data: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<Todo>>> getTODOsFromFirebase() async {
    try {
      QuerySnapshot snapshot =
          await sl<FireStoreService>().db.collection('users').doc(sl<CoreBloc>().state.deviceID).collection('todos').get();

      List<Todo> remoteTodos = [];

      for (QueryDocumentSnapshot item in snapshot.docs) {
        remoteTodos.add(Todo.fromJson(item.data() as Map<String, dynamic>));
      }

      saveTodo(todos: remoteTodos);

      return Right(remoteTodos);
    } catch (e) {
      return Left(UnknownFailure(
        messageData: 'Unable to load the TODOs from server',
        data: e,
      ));
    }
  }

  Future<void> addTODOToFirebase({required Todo todo}) async {
    bool isConnected = (await Connectivity().checkConnectivity()).isConnected();

    if (isConnected) {
      sl<FireStoreService>()
          .db
          .collection('users')
          .doc(sl<CoreBloc>().state.deviceID)
          .collection('todos')
          .doc(todo.id)
          .set(todo.toJson());
    }
  }

  Future<void> deleteTODOToFirebase({required Todo todo}) async {
    bool isConnected = (await Connectivity().checkConnectivity()).isConnected();

    if (isConnected) {
      sl<FireStoreService>().db.collection('users').doc(sl<CoreBloc>().state.deviceID).collection('todos').doc(todo.id).delete();
    }
  }
}
