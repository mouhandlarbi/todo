import 'package:flutter/material.dart';
import 'package:todo/features/model/task.dart';
import 'package:todo/features/view/componenets/task_list_tile.dart';
import 'package:todo/features/view/pages/add_task_page.dart';
import 'package:todo/utils/service/api_get_tasks.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  List<Task> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateToAddPage();
        },
        label: const Text('Add Todo'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: setTask,
          child: Visibility(
            visible: tasks.isNotEmpty,
            replacement: const Center(
              child: Text("no task yet"),
            ),
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TasksListTile(
                  task: tasks[index],
                  index: index,
                );
              },
            ),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  //----------------------------------------------------------------------------
  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: ((context) => const AddTaskPage()),
    );
    await Navigator.push(context, route);
    setTask();
    setState(() {});
  }
}
