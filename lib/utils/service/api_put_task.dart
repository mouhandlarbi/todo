import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo/features/model/task.dart';

Future<void> apiUpdateTask(Task taskToUpdate) async {
  //get the data from the form

  final body = taskToUpdate.toJson();
  print(body.toString());
  //submit updated data to the server
  final uri = Uri.parse('https://api.nstack.in/v1/todos/${taskToUpdate.id}');

  final response = await http.put(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
  //show success or fail message based on status
  print(response);
}
