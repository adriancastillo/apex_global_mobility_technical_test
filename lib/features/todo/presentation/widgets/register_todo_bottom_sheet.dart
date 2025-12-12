import 'package:apex_global_mobility_test/features/todo/presentation/providers/todo_provider.dart';
import 'package:apex_global_mobility_test/l10n/app_localizations.dart';
import 'package:apex_global_mobility_test/shared/ui/components/button.dart';
import 'package:apex_global_mobility_test/shared/ui/components/textfield.dart';
import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterTodoBottomSheet extends ConsumerStatefulWidget {
  const RegisterTodoBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const RegisterTodoBottomSheet(),
    );
  }

  @override
  ConsumerState<RegisterTodoBottomSheet> createState() =>
      _RegisterTodoBottomSheetState();
}

class _RegisterTodoBottomSheetState
    extends ConsumerState<RegisterTodoBottomSheet> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.todoRegisterTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            UISpacing.vertical_16,
            AgmTextField(labelText: AppLocalizations.of(context)!.todoRegisterLabel, controller: controller),
            UISpacing.vertical_16,
            AgmButton(
              fullWidth: true,
              onPressed: () {
                final title = controller.text.trim();
                if (title.isNotEmpty) {
                  ref.read(todosProvider.notifier).registerTodo(title);
                  Navigator.pop(context);
                }
              },
              text: AppLocalizations.of(context)!.todoRegisterButton,
            ),
            UISpacing.vertical_24,
          ],
        ),
      ),
    );
  }
}
