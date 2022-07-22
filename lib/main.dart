import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todos/bloc/todos_bloc.dart';
import 'package:flutter_bloc_todos/models/todos_model.dart';
import 'package:flutter_bloc_todos/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TodosBloc()
              ..add(LoadTodos(todos: [
                Todo(
                    id: '1',
                    task: 'Sample ToDo 1',
                    description: 'This is a test To Do'),
                Todo(
                    id: '2',
                    task: 'Sample ToDo 2',
                    description: 'This is a test To Do'),
              ])))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
