import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';
import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';

extension TodoEntityMapper on TodoModel {
  Todo toEntity() => Todo(id: id, title: title, completed: completed);
}

TodoModel fromEntityToModel(Todo todo) =>
    TodoModel(id: todo.id, title: todo.title, completed: todo.completed);
