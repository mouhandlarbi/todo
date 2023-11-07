import 'package:flutter/material.dart';
import 'package:todo/features/model/task.dart';
import 'package:todo/features/view/pages/add_task_page.dart';
import 'package:todo/utils/service/api_delete_task.dart';

class TasksListTile extends StatefulWidget {
  const TasksListTile({
    super.key,
    required this.task,
    required this.index,
  });
  final Task task;
  final int index;

  @override
  State<TasksListTile> createState() => _TasksListTileState();
}

class _TasksListTileState extends State<TasksListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: ListTile(
          title: Text(widget.task.title),
          subtitle: Text(widget.task.description),
          leading: CircleAvatar(
            child: Text(
              "${widget.index + 1}",
            ),
          ),
          trailing: PopupMenuButton(
            onSelected: (value) {
              if (value == "edit") {
                navigateToEditPage(widget.task);
              } else if (value == "delete") {
                deleteTask(widget.task.id!);
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
      ),
    );
  }

  //----------------------------------------------------------------------------
  Future<void> navigateToEditPage(Task tfe) async {
    final route = MaterialPageRoute(
      builder: ((context) => AddTaskPage(
            taskToEdite: tfe,
          )),
    );
    await Navigator.push(context, route);
    //setTask();
    //setState(() {});
  }
}
