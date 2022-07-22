import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todos_bloc.dart';
import '../models/todos_model.dart';
import 'add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: To Dos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTodoScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return CircularProgressIndicator();
          }
          if (state is TodosLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text('Pending To Dos :'),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _todosCard(context, state.todos[index]);
                      })
                ],
              ),
            );
          } else {
            return Text("Something when wrong!");
          }
        },
      ),
    );
    // } else {
    //   return const Text('Something went wrong.');
    // }
    // },
    //   ),
    // );
  }

  // Column _todo(List<Todo> todos, String status) {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 50,
  //         child: Row(
  //           children: [
  //             Text(
  //               '$status To Dos: ',
  //               style: const TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: todos.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return _todosCard(
  //             context,
  //             todos[index],
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  Card _todosCard(
    BuildContext context,
    Todo todo,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '#${todo.id}: ${todo.task}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // context.read<TodosBloc>().add(
                  //       UpdateTodo(
                  //         todo: todo.copyWith(isCompleted: true),
                  //       ),
                  //     );
                },
                icon: const Icon(Icons.add_task),
              ),
              IconButton(
                onPressed: () {
                  // context.read<TodosBloc>().add(
                  //     DeleteTodo(todo: todo.copyWith(isCancelled: true)));

                  context.read<TodosBloc>().add(DeleteTodo(todo: todo));
                },
                icon: const Icon(Icons.cancel),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
