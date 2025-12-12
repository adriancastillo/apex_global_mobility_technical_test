import 'package:apex_global_mobility_test/features/todo/data/data_sources/local/todo_local_data_source.dart';
import 'package:apex_global_mobility_test/features/todo/data/mapper/database_mapper.dart';
import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@Singleton(as: TodoLocalDataSource)
class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  TodoLocalDataSourceImpl(this.database);

  final Database database;

  @override
  Future<List<TodoModel>> fetchTodos() async {
    final maps = await database.query('todos');
    return maps.map(fromDatabaseToModel).toList();
  }

  @override
  Future<void> saveTodos(List<TodoModel> todos) async {
    final batch = database.batch();
    batch.delete('todos');

    for (final todo in todos) {
      batch.insert(
        'todos',
        todo.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<TodoModel> registerTodo(TodoModel todo) async {
    await database.insert(
      'todos',
      todo.toDatabase(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return todo;
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    await database.update(
      'todos',
      todo.toDatabase(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );

    return todo;
  }
}
