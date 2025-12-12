// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get todoTitle => 'Todos';

  @override
  String get countryTitle => 'Countries';

  @override
  String get all => 'All';

  @override
  String get completed => 'Completed';

  @override
  String get pending => 'Pending';

  @override
  String taskCompleted(Object count) {
    return '$count todos completed';
  }

  @override
  String get todoDetailTitle => 'Detail todo';

  @override
  String get todoDetailSubtitle => 'Todo:';

  @override
  String todoDetailIdentifier(Object id) {
    return 'Identifier: $id';
  }

  @override
  String get todoRegisterTitle => 'Create todo';

  @override
  String get todoRegisterLabel => 'Title';

  @override
  String get todoRegisterButton => 'Create';

  @override
  String get todoUpdateTitle => 'Update todo';

  @override
  String get todoUpdateLabel => 'New title';

  @override
  String get todoUpdateButton => 'Update';
}
