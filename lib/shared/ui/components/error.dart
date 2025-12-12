import 'package:apex_global_mobility_test/shared/ui/components/button.dart';
import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AgmErrorCard extends StatelessWidget {
  const AgmErrorCard({required this.retry, this.padding, super.key});

  final VoidCallback retry;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: padding ?? UIPadding.horizontal_16,
      padding: UIPadding.all_16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: UIBorderRadius.large,
      ),
      child: Column(
        children: [
          PhosphorIcon(
            PhosphorIcons.xCircle(PhosphorIconsStyle.light),
            size: UISizing.value_56,
          ),
          UISpacing.vertical_4,
          Text(
            '¡Ups! ocurrió un error',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          UISpacing.vertical_16,
          AgmButton(isDense: true, text: 'Reintentar', onPressed: retry),
        ],
      ),
    );
  }
}

class ErrorInlineCard extends StatelessWidget {
  const ErrorInlineCard({required this.retry, super.key});

  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: UISizing.value_12,
        vertical: UISizing.value_8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: UIBorderRadius.large,
      ),
      child: Row(
        children: [
          UISpacing.horizontal_4,
          Text(
            '¡Ups! ocurrió un error',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          UISpacing.horizontal_8,
          GestureDetector(
            onTap: retry,
            child: PhosphorIcon(PhosphorIcons.arrowClockwise()),
          ),
        ],
      ),
    );
  }
}
