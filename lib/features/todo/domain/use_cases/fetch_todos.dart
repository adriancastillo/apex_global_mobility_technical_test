import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class FetchTodos {
  final TodoRepository repository;

  FetchTodos(this.repository);

  Future<List<Todo>> call() {
    return repository.fetchTodos();
  }
}
