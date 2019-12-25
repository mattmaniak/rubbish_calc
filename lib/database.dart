import 'package:sqflite/sqflite.dart';
import 'item.dart';

class DB {
  static final String _databaseName = 'rubbish_calc.db';
  String _databaseFilename;
  Database _database;

  void _init() async {
    _databaseFilename = await getDatabasesPath() + '/' + _databaseName;

    _database = await openDatabase(_databaseFilename, version: 1,
        onCreate: (Database db, int version) async {
      final String query = 'CREATE TABLE Items('
          'id INTEGER NOT NULL PRIMARY KEY,'
          'name TEXT NOT NULL,'
          'weightGrams INTEGER NOT NULL,'
          'amountInRubbish INTEGER NOT NULL)';
      await db.execute(query);
    });
    await _database.close();
  }
}
