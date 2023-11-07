import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo/features/model/task.dart';

Future<void> submitDatas(Task taskToSubmit) async {
  //get the data from class user
  final body = taskToSubmit.toJson();
  //submit data to the server
  final uri = Uri.parse("https://api.nstack.in/v1/todos");
  final response = await http.post(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
  //show success or fail message based on status
  print(response);
  /*if (response.statusCode == 201) {
    showSuccessMessage("task added successfuly");
    titleController.text = "";
    descriptionController.text = "";
  } else {
    showErrorMessage("Error");
  }*/
}
