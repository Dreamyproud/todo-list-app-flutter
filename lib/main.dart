import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thingstodo/models/todos_model.dart';

import 'repository/todo_repository.dart';
import 'screens/todo_screen.dart';
import 'screens/welcome/start_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.indigo,
          fontFamily: 'Cera',
          popupMenuTheme: PopupMenuThemeData(elevation: 2),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xff668EE6))),
      home: Scaffold(
        body: SafeArea(child: StartPage()),
      ),
      routes: {
        "/mainScreen": (context) => MainScreen(),
        "/todoScreen": (context) => TodoScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.indigo,
          fontFamily: 'Cera',
          popupMenuTheme: PopupMenuThemeData(elevation: 2),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xff668EE6))),
      home: Scaffold(
        body: SafeArea(
            child: FutureBuilder(
          future: TodoRepoFactory.getInstance().fetchTodos(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? _buildTodosPage(snapshot)
                : Center(
                    child:
                        CircularProgressIndicator(color: Colors.transparent));
          },
        )),
      ),
    );
  }

  Widget _buildTodosPage(AsyncSnapshot snapshot) {
    return ChangeNotifierProvider(
        create: (context) => TodosModel(todos: snapshot.data),
        child: TodoScreen());
  }
}
