import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo/features/model/task.dart';

Future<List<dynamic>> apiGetTasks() async {
  final uri = Uri.parse("https://api.nstack.in/v1/todos?page=1&limit=10");
  var response = await http.get(uri);
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return json["items"];
}

Future<List<Task>> getTasks() async {
  var tasksMap = await apiGetTasks();
  return tasksMap.map((e) => Task.fromJson(e)).toList();
}
