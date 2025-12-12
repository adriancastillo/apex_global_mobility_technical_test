import 'package:apex_global_mobility_test/shared/routes/route_names.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/providers/filtererd_todos_provider.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/providers/todo_filter_provider.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/providers/todo_provider.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/widgets/register_todo_bottom_sheet.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/widgets/todo_item.dart';
import 'package:apex_global_mobility_test/l10n/app_localizations.dart';
import 'package:apex_global_mobility_test/shared/ui/components/error.dart';
import 'package:apex_global_mobility_test/shared/ui/components/scaffold.dart';
import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TodosView extends ConsumerWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(filteredTodosProvider);
    final filter = ref.watch(todoFilterProvider);

    return AgmScaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.todoTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          DropdownButton<TodoFilter>(
            value: filter,
            underline: const SizedBox(),
            onChanged: (value) {
              if (value != null) {
                ref.read(todoFilterProvider.notifier).state = value;
              }
            },
            items: [
              DropdownMenuItem(
                value: TodoFilter.all,
                child: Text(
                  AppLocalizations.of(context)!.all,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              DropdownMenuItem(
                value: TodoFilter.pending,
                child: Text(
                  AppLocalizations.of(context)!.pending,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              DropdownMenuItem(
                value: TodoFilter.completed,
                child: Text(
                  AppLocalizations.of(context)!.completed,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ],
      ),
      body: asyncTodos.when(
        data: (todos) => ListView.builder(
          padding: EdgeInsets.only(bottom: UISizing.value_96),
          itemCount: todos.length,
          itemBuilder: (_, index) => TodoItem(
            key: ValueKey(todos[index].id),
            todo: todos[index],
            onTap: () =>
                context.goNamed(RouteNames.detailTodo, extra: todos[index]),
            onToggle: () {
              ref.read(todosProvider.notifier).toggleTodo(todos[index]);
            },
          ),
        ),
        error: (_, __) => Column(
          children: [
            Padding(
              padding: UIPadding.all_24,
              child: AgmErrorCard(
                retry: ref.read(todosProvider.notifier).fetchTodos,
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: UIColors.secondary,
        onPressed: () => RegisterTodoBottomSheet.show(context),
        child: PhosphorIcon(PhosphorIcons.plus(), color: Colors.white),
      ),
    );
  }
}
