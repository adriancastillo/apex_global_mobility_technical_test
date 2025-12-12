import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Future<Database> initialize() async => openDatabase(
    join(await getDatabasesPath(), 'todo_app.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            completed INTEGER NOT NULL
          )
        ''');
    },
  );
}
