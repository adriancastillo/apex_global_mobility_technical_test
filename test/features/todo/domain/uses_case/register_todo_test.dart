import 'package:apex_global_mobility_test/features/todo/domain/use_cases/register_todo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/repositories/todo_repository.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late MockTodoRepository repository;
  late RegisterTodo usecase;

  setUp(() {
    repository = MockTodoRepository();
    usecase = RegisterTodo(repository);
  });

  test(
    'Should return new Todo when repository registers successfully',
    () async {
      // Arrange
      final newTodo = Todo(id: 42, title: 'Test task', completed: false);

      when(
        () => repository.registerTodo(newTodo),
      ).thenAnswer((_) async => newTodo);

      // Act
      final result = await usecase(newTodo);

      // Assert
      expect(result, newTodo);
      verify(() => repository.registerTodo(newTodo)).called(1);
    },
  );

  test('Should throw exception when repository fails to register', () async {
    // Arrange
    final newTodo = Todo(id: 42, title: 'Test task', completed: false);

    when(() => repository.registerTodo(newTodo)).thenThrow(Exception('Failed'));

    // Act & Assert
    expect(() async => await usecase(newTodo), throwsException);
    verify(() => repository.registerTodo(newTodo)).called(1);
  });
}
