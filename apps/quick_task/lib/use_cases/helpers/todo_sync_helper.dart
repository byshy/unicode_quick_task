import 'package:quick_task/di/injection_container.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/repos/home_repo.dart';

class TodoSyncHelper {
  static Future<void> syncRemoteWithLocal(List<Todo> localTodos, List<Todo> remoteTodos) async {
    List<String> updatedRemoteTodos = [];

    for (Todo remoteTodo in remoteTodos) {
      Todo? matchingTodo = findMatchingTodoById(localTodos, remoteTodo.id);

      if (matchingTodo == null) {
        await sl<HomeRepo>().deleteTODOToFirebase(todo: remoteTodo);
      } else if (remoteTodo != matchingTodo) {
        await sl<HomeRepo>().addTODOToFirebase(todo: matchingTodo);
      }

      updatedRemoteTodos.add(remoteTodo.id);
    }

    localTodos.removeWhere((todo) => updatedRemoteTodos.contains(todo.id));
  }

  static Todo? findMatchingTodoById(List<Todo> todos, String id) {
    try {
      return todos.firstWhere((todo) => todo.id == id);
    } catch (_) {
      return null;
    }
  }

  static Future<void> addLocalTodosToRemote(List<Todo> localTodos, List<Todo> remoteTodos) async {
    for (Todo localTodo in localTodos) {
      if (!isTodoInRemote(localTodo, remoteTodos)) {
        await sl<HomeRepo>().addTODOToFirebase(todo: localTodo);
      }
    }
  }

  static bool isTodoInRemote(Todo localTodo, List<Todo> remoteTodos) {
    return remoteTodos.any((remoteTodo) => remoteTodo.id == localTodo.id);
  }
}