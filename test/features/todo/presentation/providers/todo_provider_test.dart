import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/fetch_todos.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/register_todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/update_todo.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/providers/todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchTodos extends Mock implements FetchTodos {}

class MockRegisterTodo extends Mock implements RegisterTodo {}

class MockUpdateTodo extends Mock implements UpdateTodo {}

class FakeTodo extends Fake implements Todo {}

void main() {
  late MockFetchTodos fetchTodos;
  late MockRegisterTodo registerTodo;
  late MockUpdateTodo updateTodo;
  late TodoNotifier notifier;

  setUpAll(() {
    registerFallbackValue(FakeTodo());
  });

  setUp(() {
    fetchTodos = MockFetchTodos();
    registerTodo = MockRegisterTodo();
    updateTodo = MockUpdateTodo();

    notifier = TodoNotifier(fetchTodos, registerTodo, updateTodo);
  });

  test('Should load todos successfully', () async {
    // Arrange
    final todos = [Todo(id: 1, title: 'Test', completed: false)];

    when(() => fetchTodos()).thenAnswer((_) async => todos);

    // Act
    await notifier.fetchTodos();

    // Assert
    expect(notifier.state.asData?.value, todos);
    verify(() => fetchTodos()).called(1);
  });

  test('Should set error state when fetch fails', () async {
    // Arrange
    when(() => fetchTodos()).thenThrow(Exception('Failed'));

    // Act
    await notifier.fetchTodos();

    // Assert
    expect(notifier.state.hasError, true);
    verify(() => fetchTodos()).called(1);
  });

  test('Should register todo and append it to state', () async {
    // Arrange initial state
    notifier.state = const AsyncValue.data([
      Todo(id: 1, title: 'A', completed: false),
    ]);

    when(() => registerTodo(any())).thenAnswer((invocation) async {
      return invocation.positionalArguments.first;
    });

    // Act
    await notifier.registerTodo('New Todo');

    // Assert
    final result = notifier.state.asData!.value;

    expect(result.length, 2);
    expect(result.last.title, 'New Todo');
    verify(() => registerTodo(any())).called(1);
  });

  test('Should NOT register todo if state has no value', () async {
    notifier.state = const AsyncValue.loading();

    // Act
    await notifier.registerTodo('New Todo');

    // Assert
    verifyNever(() => registerTodo(any()));
  });

  test('Should update todo successfully', () async {
    // Arrange
    final original = Todo(id: 1, title: 'Old', completed: false);
    notifier.state = AsyncValue.data([original]);

    when(() => updateTodo(any())).thenAnswer((invocation) async {
      return invocation.positionalArguments.first;
    });

    // Act
    await notifier.updateTodo(todo: original, title: 'Updated');

    // Assert
    final updated = notifier.state.asData!.value.first;

    expect(updated.title, 'Updated');
    verify(() => updateTodo(any())).called(1);
  });

  test('Should toggle todo completed status', () async {
    // Arrange
    final original = Todo(id: 1, title: 'Test', completed: false);

    notifier.state = AsyncValue.data([original]);

    when(() => updateTodo(any())).thenAnswer((invocation) async {
      return invocation.positionalArguments.first;
    });

    // Act
    await notifier.toggleTodo(original);

    // Assert
    final result = notifier.state.asData!.value.first;

    expect(result.completed, true);
    verify(() => updateTodo(any())).called(1);
  });
}
