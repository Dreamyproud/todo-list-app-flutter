import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thingstodo/models/todos_model.dart';

import '../models/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final int index;

  TodoItem({required this.todo, required this.index});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    final notCompletedIconColor = Color(0xff4ed9d6);
    final inputCtrl = TextEditingController();
    final completedIconColor = notCompletedIconColor.withAlpha(100);

    TextStyle _taskStyle(completed) {
      if (completed)
        return TextStyle(
          fontSize: 16,
          color: Colors.black54,
          decoration: TextDecoration.lineThrough,
        );
      else
        return TextStyle(decoration: TextDecoration.none);
    }

    Widget getDissmissBackground(bool left) {
      return Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.red[400]),
        alignment: Alignment(left ? -0.9 : 0.9, 0),
        child: Icon(
          FontAwesomeIcons.trash,
          color: Colors.white,
          size: 20,
        ),
      );
    }

    return Dismissible(
      key: ValueKey<String>(widget.todo.text),
      background: getDissmissBackground(true),
      secondaryBackground: getDissmissBackground(false),
      onDismissed: (DismissDirection direction) =>
          Provider.of<TodosModel>(context, listen: false)
              .removeTodoAt(widget.index),
      child: Card(
        elevation: 0,
        color: Color(0xfffff5fb),
        child: ListTile(
          title: TextField(
            minLines: 1,
            maxLines: 5,
            textInputAction: TextInputAction.done,
            controller: inputCtrl,
            onSubmitted: (value) {
              if (inputCtrl.text.isNotEmpty) {
                Provider.of<TodosModel>(context, listen: false)
                    .toggleEditAt(widget.index, value);
              }
            },
            decoration: new InputDecoration.collapsed(
              hintText: widget.todo.text,
              hintStyle: _taskStyle(widget.todo.completed),
            ),
          ),
          subtitle: Text('${widget.todo.time.hour}:${widget.todo.time.minute}'),
          leading: IconButton(
            icon: widget.todo.completed
                ? Icon(
                    FontAwesomeIcons.checkCircle,
                    color: completedIconColor,
                  )
                : Icon(
                    FontAwesomeIcons.circle,
                    color: notCompletedIconColor,
                  ),
            onPressed: () => Provider.of<TodosModel>(context, listen: false)
                .toggleCompletedAt(widget.index),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.trash, color: Colors.red, size: 16),
                onPressed: () => Provider.of<TodosModel>(context, listen: false)
                    .removeTodoAt(widget.index),
              ),
              inputCtrl.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(FontAwesomeIcons.check,
                          color: Colors.green, size: 16),
                      onPressed: () =>
                          Provider.of<TodosModel>(context, listen: false)
                              .removeTodoAt(widget.index),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
