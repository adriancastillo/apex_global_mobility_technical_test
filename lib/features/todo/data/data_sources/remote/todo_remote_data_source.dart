import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> fetchTodos();
}
