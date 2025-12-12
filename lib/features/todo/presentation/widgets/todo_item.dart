import 'package:apex_global_mobility_test/features/todo/domain/entidades/todo.dart';
import 'package:apex_global_mobility_test/shared/ui/components/checkbox.dart';
import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onToggle,
  });

  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: UISizing.value_16,
          vertical: UISizing.value_8,
        ),
        padding: UIPadding.all_16,
        decoration: BoxDecoration(
          borderRadius: UIBorderRadius.medium,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                todo.title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  decoration: todo.completed
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),
            UISpacing.horizontal_16,
            AgmCheckbox(
              active: todo.completed,
              onChanged: (value) => onToggle(),
            ),
          ],
        ),
      ),
    );
  }
}
