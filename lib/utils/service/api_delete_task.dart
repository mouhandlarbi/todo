import 'package:http/http.dart' as http;

//static
Future<bool> deleteTask(String id) async {
  //delete the item
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final response = await http.delete(uri);
  return response.statusCode == 200;
}
