import 'package:apex_global_mobility_test/features/country/domain/entities/country.dart';
import 'package:flutter/material.dart';

class CountryItem extends StatelessWidget {
  const CountryItem({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(country.emoji, style: const TextStyle(fontSize: 24)),
      title: Text(country.name),
      subtitle: Text(country.code),
    );
  }
}
