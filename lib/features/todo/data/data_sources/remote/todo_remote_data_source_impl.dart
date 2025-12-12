import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_remote_data_source.dart';
import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_service.dart';
import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TodoRemoteDataSource)
class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  TodoRemoteDataSourceImpl(this._service);

  final TodoService _service;

  @override
  Future<List<TodoModel>> fetchTodos() async {
    return _service.getTodos();
  }
}
