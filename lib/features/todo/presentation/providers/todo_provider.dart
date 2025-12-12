import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/fetch_todos.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/register_todo.dart';
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/update_todo.dart';
import 'package:apex_global_mobility_test/shared/di/injectable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todosProvider =
    StateNotifierProvider<TodoNotifier, AsyncValue<List<Todo>>>((ref) {
      return TodoNotifier(
        getIt<FetchTodos>(),
        getIt<RegisterTodo>(),
        getIt<UpdateTodo>(),
      )..fetchTodos();
    });

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  TodoNotifier(this._fetchTodos, this._registerTodo, this._updateTodo)
    : super(const AsyncValue.loading());

  final FetchTodos _fetchTodos;
  final RegisterTodo _registerTodo;
  final UpdateTodo _updateTodo;

  Future<void> fetchTodos() async {
    try {
      final todos = await _fetchTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> registerTodo(String title) async {
    if (state.value == null) return;

    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      completed: false,
    );

    await _registerTodo(newTodo);
    state = AsyncValue.data([...state.value!, newTodo]);
  }

  Future<void> updateTodo({required Todo todo, required String title}) async {
    final updatedTodo = todo.copyWith(title: title);

    await _updateTodo(updatedTodo);

    state = AsyncValue.data(
      state.value!
          .map((todo) => todo.id == updatedTodo.id ? updatedTodo : todo)
          .toList(),
    );
  }

  Future<void> toggleTodo(Todo todo) async {
    final updatedTodo = todo.copyWith(completed: !todo.completed);

    await _updateTodo(updatedTodo);

    state = AsyncValue.data(
      state.value!
          .map((todo) => todo.id == updatedTodo.id ? updatedTodo : todo)
          .toList(),
    );
  }
}
