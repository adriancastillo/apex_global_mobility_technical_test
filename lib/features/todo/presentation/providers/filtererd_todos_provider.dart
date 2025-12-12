import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/providers/todo_filter_provider.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/providers/todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredTodosProvider = Provider<AsyncValue<List<Todo>>>((ref) {
  final todosState = ref.watch(todosProvider);
  final filter = ref.watch(todoFilterProvider);

  return todosState.whenData((todos) {
    switch (filter) {
      case TodoFilter.completed:
        return todos.where((todo) => todo.completed).toList();
      case TodoFilter.pending:
        return todos.where((todo) => !todo.completed).toList();
      default:
        return todos;
    }
  });
});
