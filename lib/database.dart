import 'package:sqflite/sqflite.dart';
import 'item.dart';

class DB {
  static final String _databaseName = 'rubbish_calc.db';
  String _databaseFilename;
  Database _databaseFile;

  void create() async {
    _databaseFilename = await getDatabasesPath() + '/' + _databaseName;

    _databaseFile = await openDatabase(_databaseFilename, version: 1,
        onCreate: (Database db, int version) async {
      final String query = 'CREATE TABLE Items('
          '_id INTEGER NOT NULL PRIMARY KEY,'
          'name TEXT NOT NULL,'
          'weightGrams INTEGER NOT NULL,'
          'amountInRubbish INTEGER NOT NULL)';
      await db.execute(query);
    });
    await _databaseFile.close();
  }

  Future<List<Item>> read() async {
    List<Item> loadedRubbish = [];
    _databaseFile = await openReadOnlyDatabase(_databaseFilename);

    await _databaseFile.close();
    return loadedRubbish;
  }

  Future<bool> exists() async {
    if(await databaseExists(_databaseFilename)) {
      return true;
    }
    return false;
  }
}
