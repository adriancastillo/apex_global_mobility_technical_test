import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';

class AgmOutlinedButton extends StatelessWidget {
  const AgmOutlinedButton({
    required this.text,
    required this.onPressed,
    this.fullWidth = false,
    this.isDense = false,
    this.icon,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;
  final bool fullWidth;
  final bool isDense;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: fullWidth ? double.maxFinite : null,
        padding: isDense
            ? EdgeInsets.symmetric(
                horizontal: UISizing.value_12,
                vertical: UISizing.value_6,
              )
            : UIPadding.all_12,
        decoration: BoxDecoration(
          borderRadius: UIBorderRadius.large,
          color: Colors.transparent,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  UISpacing.horizontal_4,
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
      ),
    );
  }
}
