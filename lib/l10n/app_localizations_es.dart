// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get todoTitle => 'Tareas';

  @override
  String get countryTitle => 'Paises';

  @override
  String get all => 'Todo';

  @override
  String get completed => 'Completada';

  @override
  String get pending => 'Pendiente';

  @override
  String taskCompleted(Object count) {
    return '$count tareas completadas';
  }

  @override
  String get todoDetailTitle => 'Detalle de la Tarea';

  @override
  String get todoDetailSubtitle => 'Tarea:';

  @override
  String todoDetailIdentifier(Object id) {
    return 'Identificador: $id';
  }

  @override
  String get todoRegisterTitle => 'Crear nueva tarea';

  @override
  String get todoRegisterLabel => 'Título';

  @override
  String get todoRegisterButton => 'Crear';

  @override
  String get todoUpdateTitle => 'Actualizar tarea';

  @override
  String get todoUpdateLabel => 'Nuevo título';

  @override
  String get todoUpdateButton => 'Actualizar';
}
