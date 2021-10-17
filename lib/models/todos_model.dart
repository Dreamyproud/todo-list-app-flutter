import 'dart:collection';

import 'package:flutter/widgets.dart';

import 'todo.dart';
import '../repository/todo_repository.dart';

class TodosModel extends ChangeNotifier {
  List<Todo> _todos;

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);
  UnmodifiableListView<Todo> get pendientes => UnmodifiableListView(_todos);
  UnmodifiableListView<Todo> get completas => UnmodifiableListView(_todos);
  TodosModel({@required todos}) : _todos = todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  removeTodoAt(int id) {
    _todos.removeAt(id);
    notifyListeners();
  }

  toggleCompletedAt(int id) {
    _todos[id].toggleCompleted();
    notifyListeners();
  }

  toggleEditAt(int id, String newText) {
    _todos[id].toggleUpdate(newText);
    notifyListeners();
  }

  List<Todo> getCompletedTasks() {
    return _todos.where((t) => t.completed == true).toList();
  }

  List<Todo> getActiveTasks() {
    final list = _todos.where((t) => t.completed == false).toList();
    final ids = list.map((e) => e.text).toSet();
    list.retainWhere((x) => ids.remove(x.text));
    return list;
  }

  clearAll() {
    _todos.clear();
    notifyListeners();
  }

  @override
  notifyListeners() {
    super.notifyListeners();
    persist(this.todos);
  }
}

persist(todos) {
  TodoRepoFactory.getInstance().saveTodos(todos);
}
