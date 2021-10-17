import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

class TodoRepoFactory {
  static TodoRepository getInstance() => PrefsTodoRepo();
}

abstract class TodoRepository {
  fetchTodos();
  saveTodos(List<Todo> todos);
}

class PrefsTodoRepo implements TodoRepository {
  final kKey = 'flutter_todos';

  @override
  Future<List<Todo>> fetchTodos() async {
    final listToDo = <Todo>[];
    var prefs = await SharedPreferences.getInstance();
    final prefsDecode = prefs.getString(kKey);
    if (prefsDecode != null) {
      return TodosJsonDecoder().decode(prefs.getString(kKey) ?? '');
    }
    return listToDo;
  }

  @override
  saveTodos(List<Todo> todos) async {
    var prefs = await SharedPreferences.getInstance();

    var jsonString = jsonEncode(todos);
  }
}

abstract class TodosDecoder {
  List<Todo> decode(String source);
}

class TodosJsonDecoder implements TodosDecoder {
  List<Todo> decode(String source) {
    var json = jsonDecode(source) as List;
    return json.map((item) => Todo.fromJson(item)).toList();
  }
}

class MemoryTodoRepo implements TodoRepository {
  @override
  Future<List<Todo>> fetchTodos() async {
    return Future.delayed(
        Duration(milliseconds: 2000),
        () => [
              Todo(text: 'buy milk', time: DateTime.now()),
              Todo(text: 'type your todo', time: DateTime.now())
            ]);
  }

  @override
  saveTodos(List<Todo> todos) async {
    var json = jsonEncode(todos);
    await Future.delayed(Duration(seconds: 1));
  }
}
