import 'package:dartz/dartz.dart';
import 'package:firebase_cluster/firestore_service.dart';
import 'package:local_storage/exports.dart';
import 'package:quick_task/core/bloc/core_bloc.dart';

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

  void addTODOToFirebase({required Todo todo}) {
    sl<FireStoreService>()
        .db
        .collection('users')
        .doc(sl<CoreBloc>().state.deviceID)
        .collection('todos')
        .doc(todo.id)
        .set(todo.toJson());
  }

  void deleteTODOToFirebase({required Todo todo}) {
    sl<FireStoreService>()
        .db
        .collection('users')
        .doc(sl<CoreBloc>().state.deviceID)
        .collection('todos')
        .doc(todo.id)
        .delete();
  }
}
