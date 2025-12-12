import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AgmCheckbox extends StatelessWidget {
  const AgmCheckbox({
    super.key,
    required this.active,
    required this.onChanged,
    this.isDisabled = false,
    this.size = 24,
    this.activeColor = UIColors.secondary,
    this.borderColor = Colors.black,
  });

  final bool active;
  final bool isDisabled;
  final double size;
  final Color activeColor;
  final Color borderColor;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : () => onChanged(!active),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: active ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: active
              ? null
              : Border.all(
                  color: isDisabled ? Colors.grey.shade400 : borderColor,
                  width: 1.5,
                ),
        ),
        child: active
            ? PhosphorIcon(
                PhosphorIcons.check(),
                size: size * 0.7,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
