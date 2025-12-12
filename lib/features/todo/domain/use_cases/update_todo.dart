import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<Todo> call(Todo todo) {
    return repository.updateTodo(todo);
  }
}
