import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Task {
  Task({String? id, required this.title, this.description, this.isDone})
      : id = id ?? uuid.v4();

  final String id;
  final String title;
  final String? description;
  bool? isDone = false;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'] ?? false,
    );
  }
}
