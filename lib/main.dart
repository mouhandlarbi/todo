import 'package:flutter/material.dart';
import 'package:todo/features/view/pages/tasks_list_view.dart';

import 'screens/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      //home: const  TodoListPage(),
      home: const TasksListView(),
    );
  }
}