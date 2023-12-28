import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static _initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'taskDb.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, taskName TEXT,TaskDiscription TEXT,employee TEXT  )');
    });
  }

  static Database? _database;
  static Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    await _initDb();
    return _database!;
  }
}
