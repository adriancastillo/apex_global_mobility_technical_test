import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AgmEmptyStateCard extends StatelessWidget {
  const AgmEmptyStateCard({this.padding, super.key});

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
            PhosphorIcons.empty(PhosphorIconsStyle.light),
            size: UISizing.value_56,
          ),
          UISpacing.vertical_8,
          Text(
            'No se encontraron resultados.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
