class Task {
  late String title;
  late String description;
  String? id;
  late bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.id,
    required this.isCompleted,
  });

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    id = json["_id"];
    isCompleted = json["is_completed"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data["is_completed"] = isCompleted;
    return data;
  }
}
