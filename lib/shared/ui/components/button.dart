import 'dart:async';

import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';

enum AgmButtonType {
  primary(UIColors.secondary),
  danger(UIColors.danger);

  const AgmButtonType(this.color);

  final Color color;
}

class AgmButton extends StatefulWidget {
  const AgmButton({
    this.type = AgmButtonType.primary,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.fullWidth = false,
    this.isDense = false,
    this.debounceDuration = Durations.extralong2,
    this.icon,
    super.key,
  });

  final AgmButtonType type;
  final String text;
  final VoidCallback onPressed;
  final bool isDisabled;
  final bool fullWidth;
  final bool isDense;
  final Widget? icon;
  final Duration debounceDuration;

  @override
  State<AgmButton> createState() => _AgmButtonState();
}

class _AgmButtonState extends State<AgmButton> {
  bool _isWaiting = false;
  Timer? _debounceTimer;

  void _handlePress() {
    if (_isWaiting) return;

    widget.onPressed();
    setState(() => _isWaiting = true);

    _debounceTimer = Timer(widget.debounceDuration, () {
      if (mounted) setState(() => _isWaiting = false);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDisabled ? null : _handlePress,
      child: Container(
        width: widget.fullWidth ? double.maxFinite : null,
        padding: widget.isDense
            ? EdgeInsets.symmetric(
                horizontal: UISizing.value_12,
                vertical: UISizing.value_6,
              )
            : UIPadding.all_12,
        decoration: BoxDecoration(
          borderRadius: UIBorderRadius.large,
          color: widget.isDisabled ? Colors.grey.shade300 : widget.type.color,
        ),
        child: widget.icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icon!,
                  UISpacing.horizontal_4,
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: widget.isDisabled ? Colors.black45 : Colors.white,
                    ),
                  ),
                ],
              )
            : Text(
                widget.text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: widget.isDisabled ? Colors.black45 : Colors.white,
                ),
              ),
      ),
    );
  }
}
