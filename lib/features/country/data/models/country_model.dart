import 'package:apex_global_mobility_test/features/country/domain/entities/country.dart';

class CountryModel {
  final String code;
  final String name;
  final String emoji;

  CountryModel({required this.code, required this.name, required this.emoji});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json['code'],
      name: json['name'],
      emoji: json['emoji'],
    );
  }

  Country toEntity() => Country(code: code, name: name, emoji: emoji);
}
