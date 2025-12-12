import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/fetch_todos.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late MockTodoRepository repo;
  late FetchTodos usecase;

  setUp(() {
    repo = MockTodoRepository();
    usecase = FetchTodos(repo);
  });

  test('Should return todo list when repository succeeds', () async {
    when(() => repo.fetchTodos()).thenAnswer(
      (_) async => [const Todo(id: 1, title: "Test", completed: false)],
    );

    final result = await usecase();

    expect(result.length, 1);
    expect(result.first.title, "Test");
    verify(() => repo.fetchTodos()).called(1);
  });

  test('Should throw exception when repository fails', () async {
    when(() => repo.fetchTodos()).thenThrow(Exception());

    expect(() => usecase(), throwsException);
    verify(() => repo.fetchTodos()).called(1);
  });
}
