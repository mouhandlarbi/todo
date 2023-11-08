import 'package:flutter/material.dart';
import 'package:todo/features/model/task.dart';
import 'package:todo/utils/service/api_post_task.dart';
import 'package:todo/utils/service/api_put_task.dart';
import 'package:todo/utils/snack/snackbar_helper.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    super.key,
    this.taskToEdite,
  });
  final Task? taskToEdite;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.taskToEdite != null) {
      isEdit = true;
      //final title = widget.taskToEdite!.title;
      final description = widget.taskToEdite!.description;
      titleController.text = widget.taskToEdite!.title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEdit ? const Text("Edite a task") : const Text("Add a Task"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Title",
            ),
          ),
          TextField(
            controller: descriptionController,
            minLines: 5,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: "Description",
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            //onPressed: () => submitData(),
            child: isEdit ? const Text("Update") : const Text("Submit"),
          )
        ],
      ),
    );
  }

  //-----------------------------add task
  Future<void> submitData() async {
    //get the data from form
    final Task taskFromForm = Task(
      title: titleController.text,
      description: descriptionController.text,
      isCompleted: false,
    );
    var isSuccess = await apiPostTask(taskFromForm);
    if (isSuccess) {
      showSuccessMessage(context, message: "task updated successfuly");
      Navigator.of(context).pop();
    } else {
      showErrorMessage(context, message: "Error");
    }
  }

  //--------------------------------update task

  Future<void> updateData() async {
    //get the data from the form
    if (widget.taskToEdite == null) {
      print('you can not call updated wihout todo data');
      return;
    }
    final Task taskFromForm = Task(
      title: titleController.text,
      description: descriptionController.text,
      isCompleted: false,
      id: widget.taskToEdite!.id,
    );
    //print("data to update : ${taskFromForm.title}");
    var isSuccess = await apiUpdateTask(taskFromForm);
    if (isSuccess) {
      showSuccessMessage(context, message: "task updated successfuly");
    } else {
      showErrorMessage(context, message: "Error");
    }
  }
}
