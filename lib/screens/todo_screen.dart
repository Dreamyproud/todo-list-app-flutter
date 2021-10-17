import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';
import '../widgets/todo_item.dart';
import '../models/todos_model.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen();

  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen>
    with SingleTickerProviderStateMixin {
  final inputCtrlCreate = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const CustomAppBar(),
          _buildList(),
          _buildInputRow(),
        ],
      ),
    ));
  }

  Widget _buildList() {
    return Consumer<TodosModel>(builder: (context, model, _) {
      return Expanded(
          child: ListView(
        children: [
          Column(
            children: [
              model.todos.length != 0
                  ? ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: model.todos.length,
                      itemBuilder: _todoItemBuilder,
                    )
                  : Column(
                      children: [
                        SizedBox(height: 100),
                        Center(
                          child: Text(
                            'Empieza con una nueva tarea',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        SizedBox(height: 40),
                        Image.asset(
                          'assets/list-empty.png',
                          width: 200,
                        ),
                      ],
                    ),
              model.getActiveTasks().length != 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pendientes: ${model.getActiveTasks().length}',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w200,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: model.getActiveTasks().length,
                          itemBuilder: _todoItemBuilderActive,
                        )
                      ],
                    )
                  : Container(),
              model.getCompletedTasks().length != 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Completas: ${model.getCompletedTasks().length}',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w200,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: model.getCompletedTasks().length,
                          itemBuilder: _todoItemBuilderCompleted,
                        ),
                      ],
                    )
                  : Container()
            ],
          )
        ],
      ));
    });
  }

  Widget _buildInputRow() {
    return Container(
      margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                if (inputCtrlCreate.text.isNotEmpty) {
                  var todo = Todo(
                      text: inputCtrlCreate.text.trim(), time: DateTime.now());
                  Provider.of<TodosModel>(context, listen: false).addTodo(todo);

                  setState(() {
                    inputCtrlCreate.text = '';
                  });

                  _scrollToBottom();
                }
              },
              controller: inputCtrlCreate,
              decoration: InputDecoration(
                hintText: 'Escribe tus tareas aquí',
                border: InputBorder.none,
              ),
            ),
          ),
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.indigo,
            textColor: Colors.white,
            child: Text('+ Crear'),
            onPressed: () {
              if (inputCtrlCreate.text.isNotEmpty) {
                var todo = Todo(
                    text: inputCtrlCreate.text.trim(), time: DateTime.now());
                final validateText =
                    Provider.of<TodosModel>(context, listen: false).todos;

                if (validateText.isNotEmpty) {
                  for (var item in validateText) {
                    if (item.text == todo.text) {
                      Fluttertoast.showToast(
                          msg: "Ya existe una tarea para ${item.text}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    } else {
                      Provider.of<TodosModel>(context, listen: false)
                          .addTodo(todo);
                      setState(() {
                        inputCtrlCreate.text = '';
                      });
                      _scrollToBottom();
                    }
                  }
                } else {
                  Provider.of<TodosModel>(context, listen: false).addTodo(todo);
                  setState(() {
                    inputCtrlCreate.text = '';
                  });
                  _scrollToBottom();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _todoItemBuilder(BuildContext context, int index) {
    final todo = Provider.of<TodosModel>(context, listen: false).todos[index];
    return TodoItem(
      todo: todo,
      index: index,
    );
  }

  Widget _todoItemBuilderActive(BuildContext context, int index) {
    final todo =
        Provider.of<TodosModel>(context, listen: false).getActiveTasks()[index];
    return TodoItem(
      todo: todo,
      index: index,
    );
  }

  Widget _todoItemBuilderCompleted(BuildContext context, int index) {
    final todo = Provider.of<TodosModel>(context, listen: false)
        .getCompletedTasks()[index];
    return TodoItem(
      todo: todo,
      index: index,
    );
  }

  void _scrollToBottom() {
    if (_scrollController.positions.toList().isNotEmpty) {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease);
    }
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar();
  @override
  Widget build(BuildContext context) {
    final todosModel = Provider.of<TodosModel>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(top: 18, bottom: 18, right: 5),
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'To-do list',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.indigo,
                    textColor: Colors.white,
                    child: Text('Borrar todo'),
                    onPressed: () => todosModel.clearAll(),
                  ),
                ]),
          ),
        ),
        todosModel.todos.length != 0
            ? Text(
                'Todas: ${todosModel.todos.length}',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w200,
                    color: Theme.of(context).colorScheme.secondary),
              )
            : Container()
      ],
    );
  }
}
