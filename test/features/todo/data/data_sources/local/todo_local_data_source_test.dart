import 'package:apex_global_mobility_test/features/todo/data/data_sources/local/todo_local_data_source_impl.dart';
import 'package:apex_global_mobility_test/features/todo/data/mapper/database_mapper.dart';
import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';

class MockDatabase extends Mock implements Database {}

class MockBatch extends Mock implements Batch {}

class TodoModelFake extends Fake implements TodoModel {}

void main() {
  late TodoLocalDataSourceImpl dataSource;
  late MockDatabase mockDb;
  late MockBatch mockBatch;

  setUpAll(() {
    registerFallbackValue(TodoModelFake());
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockDb = MockDatabase();
    mockBatch = MockBatch();

    dataSource = TodoLocalDataSourceImpl(mockDb);
  });

  test('Should return list of TodoModels when database returns rows', () async {
    // Arrange
    final rows = [
      {'id': 1, 'title': 'Test', 'completed': 0},
    ];

    when(() => mockDb.query('todos')).thenAnswer((_) async => rows);

    // Act
    final result = await dataSource.fetchTodos();

    // Assert
    expect(result.length, 1);
    expect(result.first.id, 1);
    verify(() => mockDb.query('todos')).called(1);
  });

  test('Should throw exception when database fails on fetchTodos', () async {
    // Arrange
    when(() => mockDb.query('todos')).thenThrow(Exception('DB error'));

    // Act & Assert
    expect(() => dataSource.fetchTodos(), throwsA(isA<Exception>()));
    verify(() => mockDb.query('todos')).called(1);
  });

  test('Should save todos correctly using batch', () async {
    // Arrange
    final todos = [TodoModel(id: 1, title: 'Test', completed: false)];

    when(() => mockDb.batch()).thenReturn(mockBatch);

    when(() => mockBatch.delete('todos')).thenReturn(null);
    when(
      () => mockBatch.insert(
        'todos',
        todos.first.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    ).thenReturn(null);

    when(
      () => mockBatch.commit(noResult: true),
    ).thenAnswer((_) async => Future.value([]));

    // Act
    await dataSource.saveTodos(todos);

    // Assert
    verify(() => mockDb.batch()).called(1);
    verify(() => mockBatch.delete('todos')).called(1);
    verify(
      () => mockBatch.insert(
        'todos',
        todos.first.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    ).called(1);
    verify(() => mockBatch.commit(noResult: true)).called(1);
  });

  test('Should throw exception when database fails on saveTodos', () async {
    // Arrange
    final todos = [TodoModel(id: 1, title: 'Test', completed: false)];

    when(() => mockDb.batch()).thenReturn(mockBatch);

    when(() => mockBatch.delete('todos')).thenThrow(Exception('DB error'));

    // Act & Assert
    expect(() => dataSource.saveTodos(todos), throwsA(isA<Exception>()));

    verify(() => mockDb.batch()).called(1);
    verify(() => mockBatch.delete('todos')).called(1);
  });

  test('Should insert todo and return it when registering todo', () async {
    // Arrange
    final todo = TodoModel(id: 10, title: 'New Todo', completed: false);

    when(
      () => mockDb.insert(
        'todos',
        todo.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    ).thenAnswer((_) async => 1);

    // Act
    final result = await dataSource.registerTodo(todo);

    // Assert
    expect(result, todo);
    verify(
      () => mockDb.insert(
        'todos',
        todo.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    ).called(1);
  });

  test('Should throw exception when database fails on registerTodo', () async {
    // Arrange
    final todo = TodoModel(id: 10, title: 'New Todo', completed: false);

    when(
      () => mockDb.insert(
        'todos',
        todo.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    ).thenThrow(Exception('DB error'));

    // Act & Assert
    expect(() => dataSource.registerTodo(todo), throwsA(isA<Exception>()));

    verify(
      () => mockDb.insert(
        'todos',
        todo.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    ).called(1);
  });

  test('Should update todo and return updated model', () async {
    // Arrange
    final todo = TodoModel(id: 20, title: 'Updated Todo', completed: true);

    when(
      () => mockDb.update(
        'todos',
        todo.toDatabase(),
        where: 'id = ?',
        whereArgs: [todo.id],
      ),
    ).thenAnswer((_) async => 1);

    // Act
    final result = await dataSource.updateTodo(todo);

    // Assert
    expect(result, todo);
    verify(
      () => mockDb.update(
        'todos',
        todo.toDatabase(),
        where: 'id = ?',
        whereArgs: [todo.id],
      ),
    ).called(1);
  });

  test('Should throw exception when database fails on updateTodo', () async {
    // Arrange
    final todo = TodoModel(id: 20, title: 'Updated Todo', completed: true);

    when(
      () => mockDb.update(
        'todos',
        todo.toDatabase(),
        where: 'id = ?',
        whereArgs: [todo.id],
      ),
    ).thenThrow(Exception('DB error'));

    // Act & Assert
    expect(() => dataSource.updateTodo(todo), throwsA(isA<Exception>()));

    verify(
      () => mockDb.update(
        'todos',
        todo.toDatabase(),
        where: 'id = ?',
        whereArgs: [todo.id],
      ),
    ).called(1);
  });
}
