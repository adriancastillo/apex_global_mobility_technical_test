import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> fetchTodos();
  Future<void> saveTodos(List<TodoModel> todos);
  Future<TodoModel> registerTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
}
