import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/l10n/app_localizations.dart';
import 'package:apex_global_mobility_test/shared/ui/components/scaffold.dart';
import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TodoDetailView extends StatelessWidget {
  const TodoDetailView({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return AgmScaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todoDetailTitle),
        backgroundColor: todo.completed ? Colors.green : Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: UIPadding.all_24,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: UISizing.value_24,
                  vertical: UISizing.value_10,
                ),
                decoration: BoxDecoration(
                  color: todo.completed
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                  borderRadius: UIBorderRadius.medium,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PhosphorIcon(
                      todo.completed
                          ? PhosphorIcons.checkCircle()
                          : PhosphorIcons.clock(),
                      color: todo.completed ? Colors.green : Colors.orange,
                    ),
                    UISpacing.horizontal_8,
                    Text(
                      todo.completed
                          ? AppLocalizations.of(context)!.completed
                          : AppLocalizations.of(context)!.pending,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: todo.completed ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              UISpacing.vertical_40,
              Container(
                width: double.infinity,
                padding: UIPadding.all_24,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: UIBorderRadius.medium,
                ),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.todoDetailSubtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.black45),
                    ),
                    UISpacing.vertical_10,
                    Text(
                      todo.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              UISpacing.vertical_24,
              Text(
                AppLocalizations.of(context)!.todoDetailIdentifier(todo.id),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
