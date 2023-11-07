import 'package:http/http.dart' as http;

Future<void> deleteTask(String id) async {
  //delete the item
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final response = await http.delete(uri);
  if (response.statusCode == 200) {
    //refresh the screen after the delete
    /*fetchTodo();
      setState(() {});*/
  } else {
    // show an error
    //showErrorMessage("Error");
  }
}
