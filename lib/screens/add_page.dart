import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      isEdit = true;
      final title = widget.todo!["title"];
      final description = widget.todo!["description"];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEdit ? const Text("Edit Todo") : const Text("Add Todo"),
        centerTitle: true,
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
            child: isEdit ? const Text("Update") : const Text("Submit"),
          )
        ],
      ),
    );
  }

  Future<void> submitData() async {
    //get the daya from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    //submit data to the server
    final url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    //show success or fail message based on status
    if (response.statusCode == 201) {
      showSuccessMessage("task added successfuly");
      titleController.text = "";
      descriptionController.text = "";
    } else {
      showErrorMessage("Error");
    }
  }

  Future<void> updateData() async {
    //get the data from the form
    if (widget.todo == null) {
      print('you can not call updated wihout todo data');
      return;
    }
    final id = widget.todo!["id"];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    //submit updated data to the server
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    //show success or fail message based on status
    if (response.statusCode == 200) {
      showSuccessMessage("task updated successfuly");
    } else {
      showErrorMessage("Error");
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
