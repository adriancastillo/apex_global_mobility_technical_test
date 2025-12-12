import 'package:apex_global_mobility_test/features/todo/data/data_sources/local/todo_local_data_source.dart';
import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_remote_data_source.dart';
import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';
import 'package:apex_global_mobility_test/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocal extends Mock implements TodoLocalDataSource {}

class MockRemote extends Mock implements TodoRemoteDataSource {}

class TodoModelFake extends Fake implements TodoModel {}

class TodoFake extends Fake implements Todo {}

void main() {
  late TodoRepositoryImpl repository;
  late MockLocal local;
  late MockRemote remote;

  setUpAll(() {
    registerFallbackValue(TodoModelFake());
    registerFallbackValue(TodoFake());
  });

  setUp(() {
    local = MockLocal();
    remote = MockRemote();
    repository = TodoRepositoryImpl(local: local, remote: remote);
  });

  test('Should return todos from local when local is not empty', () async {
    // Arrange
    when(() => local.fetchTodos()).thenAnswer(
      (_) async => [TodoModel(id: 1, title: 'Local Todo', completed: false)],
    );

    // Act
    final result = await repository.fetchTodos();

    // Assert
    expect(result.length, 1);
    expect(result.first.title, 'Local Todo');
    verify(() => local.fetchTodos()).called(1);
    verifyNever(() => remote.fetchTodos());
  });

  test(
    'Should fetch remote todos when local is empty and save them locally',
    () async {
      // Arrange
      when(() => local.fetchTodos()).thenAnswer((_) async => []);
      when(() => remote.fetchTodos()).thenAnswer(
        (_) async => [TodoModel(id: 10, title: 'Remote Todo', completed: true)],
      );
      when(() => local.saveTodos(any())).thenAnswer((_) async => {});

      // Act
      final result = await repository.fetchTodos();

      // Assert
      expect(result.first.id, 10);
      expect(result.first.title, 'Remote Todo');

      verify(() => local.fetchTodos()).called(1);
      verify(() => remote.fetchTodos()).called(1);
      verify(() => local.saveTodos(any())).called(1);
    },
  );

  test('Should throw exception when local.fetchTodos throws', () async {
    // Arrange
    when(() => local.fetchTodos()).thenThrow(Exception('DB error'));

    // Assert
    expect(() => repository.fetchTodos(), throwsException);
    verify(() => local.fetchTodos()).called(1);
    verifyNever(() => remote.fetchTodos());
  });

  test('Should throw when remote fails after local returns empty', () async {
    // Arrange
    when(() => local.fetchTodos()).thenAnswer((_) async => []);
    when(() => remote.fetchTodos()).thenThrow(Exception('Server error'));

    // Assert
    await expectLater(repository.fetchTodos(), throwsException);

    verify(() => local.fetchTodos()).called(1);
    verify(() => remote.fetchTodos()).called(1);
  });

  test(
    'Should return new Todo when repository registers successfully',
    () async {
      // Arrange
      final todo = Todo(id: 0, title: 'New todo', completed: false);

      when(() => local.registerTodo(any())).thenAnswer(
        (_) async => TodoModel(id: 99, title: 'Update me', completed: true),
      );

      // Act
      final result = await repository.registerTodo(todo);

      // Assert
      expect(result.title, 'New todo');
      verify(() => local.registerTodo(any())).called(1);
    },
  );

  test('Should throw exception when local.registerTodo fails', () async {
    // Arrange
    final todo = Todo(id: 0, title: 'New todo', completed: false);

    when(() => local.registerTodo(any())).thenThrow(Exception('Insert error'));

    // Assert
    expect(() => repository.registerTodo(todo), throwsException);
    verify(() => local.registerTodo(any())).called(1);
  });

  test('Should update todo and return updated entity', () async {
    // Arrange
    final todo = Todo(id: 99, title: 'Update me', completed: true);

    when(() => local.updateTodo(any())).thenAnswer(
      (_) async => TodoModel(id: 99, title: 'Update me', completed: true),
    );

    // Act
    final result = await repository.updateTodo(todo);

    // Assert
    expect(result.id, 99);
    expect(result.title, 'Update me');
    verify(() => local.updateTodo(any())).called(1);
  });

  test('Should throw exception when local.updateTodo fails', () async {
    // Arrange
    final todo = Todo(id: 5, title: 'New todo', completed: false);

    when(() => local.updateTodo(any())).thenThrow(Exception('Update failed'));

    // Assert
    expect(() => repository.updateTodo(todo), throwsException);
    verify(() => local.updateTodo(any())).called(1);
  });
}
