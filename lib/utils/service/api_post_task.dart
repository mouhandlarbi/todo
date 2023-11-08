import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo/features/model/task.dart';

Future<bool> apiPostTask(Task taskToSubmit) async {
  //get the data from class user
  final body = taskToSubmit.toJson();
  //submit data to the server
  final uri = Uri.parse("https://api.nstack.in/v1/todos");
  final response = await http.post(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
  //return success or fail message based on status
  return response.statusCode == 201;
}
