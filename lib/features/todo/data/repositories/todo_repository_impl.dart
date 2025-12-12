import 'package:apex_global_mobility_test/features/todo/data/data_sources/local/todo_local_data_source.dart';
import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_remote_data_source.dart';
import 'package:apex_global_mobility_test/features/todo/data/mapper/entity_mapper.dart';
import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';
import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required this.remote, required this.local});

  final TodoRemoteDataSource remote;
  final TodoLocalDataSource local;

  @override
  Future<List<Todo>> fetchTodos() async {
    final localTodos = await local.fetchTodos();

    if (localTodos.isNotEmpty) {
      return localTodos.map((todo) => todo.toEntity()).toList();
    }

    final remoteTodos = await remote.fetchTodos();
    await local.saveTodos(remoteTodos);

    return remoteTodos.map((todo) => todo.toEntity()).toList();
  }

  @override
  Future<Todo> registerTodo(Todo todo) async {
    final newTodo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: todo.title,
      completed: todo.completed,
    );

    await local.registerTodo(newTodo);
    return newTodo.toEntity();
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    final model = fromEntityToModel(todo);
    await local.updateTodo(model);
    return todo;
  }
}
