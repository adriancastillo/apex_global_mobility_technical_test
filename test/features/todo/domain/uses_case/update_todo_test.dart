import 'package:apex_global_mobility_test/features/todo/domain/use_cases/update_todo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/repositories/todo_repository.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

class FakeTodo extends Fake implements Todo {}

void main() {
  late UpdateTodo usecase;
  late MockTodoRepository repository;

  setUpAll(() {
    registerFallbackValue(FakeTodo());
  });

  setUp(() {
    repository = MockTodoRepository();
    usecase = UpdateTodo(repository);
  });

  test(
    'Should return updated Todo when repository updates successfully',
    () async {
      final updatedTodo = Todo(
        id: 1,
        title: 'Updated title',
        completed: true,
      );

      when(
        () => repository.updateTodo(any()),
      ).thenAnswer((_) async => updatedTodo);

      final result = await usecase(updatedTodo);

      expect(result, updatedTodo);
      verify(() => repository.updateTodo(updatedTodo)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'Should throw an exception when repository fails to update Todo',
    () async {
      final todoToUpdate = Todo(id: 1, title: 'Updated title', completed: false);

      when(
        () => repository.updateTodo(any()),
      ).thenThrow(Exception('Update failed'));

      expect(() => usecase(todoToUpdate), throwsException);

      verify(() => repository.updateTodo(todoToUpdate)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
