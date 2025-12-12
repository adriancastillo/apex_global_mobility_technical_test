import 'package:apex_global_mobility_test/shared/database/app_database.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import 'injectable.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  final db = await AppDatabase.initialize();  
  getIt.registerSingleton<Database>(db);
  getIt.init();
}
