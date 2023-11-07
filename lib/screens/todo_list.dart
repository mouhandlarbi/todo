import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/features/model/task.dart';
import 'package:todo/features/view/componenets/task_list_tile.dart';
import 'package:todo/screens/add_page.dart';
import 'package:http/http.dart' as http;
import 'package:todo/utils/service/api_get_tasks.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List items = [];
  List<Task> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTodo();
    setTask();
  }

  Future<void> setTask() async {
    isLoading = true;
    setState(() {});
    tasks = await getTasks();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateToAddPage();
        },
        label: const Text('Add Todo'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final id = items[index]["_id"] as String;
              return Column(
                children: [
                  TasksListTile(task: tasks[index], index: index),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        "${index + 1}",
                      ),
                    ),
                    title: Text(items[index]["title"]),
                    subtitle: Text(
                      tasks.length.toString(),
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == "edit") {
                          navigateToEditPage(items[index]);
                        } else if (value == "delete") {
                          deleteById(id);
                          //deleteTask(id);
                        }
                      },
                      itemBuilder: ((context) {
                        return [
                          const PopupMenuItem(
                            value: "edit",
                            child: Text("Edit"),
                          ),
                          const PopupMenuItem(
                            value: "delete",
                            child: Text("Delete"),
                          ),
                        ];
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: ((context) => const AddTodoPage()),
    );
    await Navigator.push(context, route);
    fetchTodo();
    setState(() {});
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: ((context) => AddTodoPage(todo: item)),
    );
    await Navigator.push(context, route);
    fetchTodo();
    setState(() {});
  }

  Future<void> fetchTodo() async {
    isLoading = true;
    setState(() {});
    final url = "https://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json["items"] as List;
      items = result;
      setState(() {});
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> deleteById(String id) async {
    //delete the item
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      //remove the item from the list
      fetchTodo();
      setState(() {});
    } else {
      // show an error
      //showErrorMessage("Error");
    }
  }
}
