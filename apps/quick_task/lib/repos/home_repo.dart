import 'package:dartz/dartz.dart';
import 'package:local_storage/exports.dart';

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
}
