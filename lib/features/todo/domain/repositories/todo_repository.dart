import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();

  Future<Todo> registerTodo(Todo todo);

  Future<Todo> updateTodo(Todo todo);
}
