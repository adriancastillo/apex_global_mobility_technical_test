import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/features/todo/presentation/providers/todo_provider.dart';
import 'package:apex_global_mobility_test/l10n/app_localizations.dart';
import 'package:apex_global_mobility_test/shared/ui/components/button.dart';
import 'package:apex_global_mobility_test/shared/ui/components/textfield.dart';
import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateTodoBottomSheet extends ConsumerStatefulWidget {
  const UpdateTodoBottomSheet({super.key, required this.todo});

  final Todo todo;

  static void show({required BuildContext context, required Todo todo}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => UpdateTodoBottomSheet(todo: todo),
    );
  }

  @override
  ConsumerState<UpdateTodoBottomSheet> createState() =>
      _UpdateTodoBottomSheetState();
}

class _UpdateTodoBottomSheetState extends ConsumerState<UpdateTodoBottomSheet> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.todo.title);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: UIPadding.all_16,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.todoUpdateTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            UISpacing.vertical_16,
            AgmTextField(
              labelText: AppLocalizations.of(context)!.todoUpdateLabel,
              controller: controller,
            ),
            UISpacing.vertical_16,
            AgmButton(
              onPressed: () {
                final newTitle = controller.text.trim();
                if (newTitle.isNotEmpty) {
                  ref
                      .read(todosProvider.notifier)
                      .updateTodo(todo: widget.todo, title: newTitle);
                  Navigator.pop(context);
                }
              },
              text: AppLocalizations.of(context)!.todoUpdateButton,
            ),
          ],
        ),
      ),
    );
  }
}
