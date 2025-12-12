import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';

extension TodoDatabaseMapper on TodoModel {
  Map<String, dynamic> toDatabase() {
    return {'id': id, 'title': title, 'completed': completed ? 1 : 0};
  }
}

TodoModel fromDatabaseToModel(Map<String, dynamic> map) {
  return TodoModel(
    id: map['id'] as int,
    title: map['title'] as String,
    completed: (map['completed'] as int) == 1,
  );
}
