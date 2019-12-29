import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'item.dart';

class DB {
  static final String _databaseName = 'rubbish_calc.db';
  final String _tableName = 'Items';
  String _databaseFilename;
  Database _databaseFile;

  DB() {
    _setDatabaseFilename();
  }

  void _setDatabaseFilename() async {
    _databaseFilename = await getDatabasesPath() + '/' + _databaseName;
  }

  void create() async {
    _databaseFile = await openDatabase(_databaseFilename, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE $_tableName('
          'id INTEGER NOT NULL PRIMARY KEY,'
          'numberInRubbish INTEGER NOT NULL)');
    });
    debugPrint('HELLO_1'); // Works.

    await _databaseFile.close();
  }

  Future<List<Item>> read(List<Item> rubbish) async {
    List<Item> loadedRubbishConfig = [];
    int numberOfRows = 0;
    _databaseFile = await openReadOnlyDatabase(_databaseFilename);

    numberOfRows = Sqflite.firstIntValue(
        await _databaseFile.rawQuery('SELECT COUNT(*) FROM  $_tableName'));

    // if(numberOfRows != rubbish.length) {
    //   return rubbish;
    // }
    debugPrint('HELLO_2'); // Works.

    List<Map<String, dynamic>> fetchedData =
        await _databaseFile.query(_tableName);

    debugPrint(fetchedData.toString());

    await _databaseFile.close();
    return rubbish;
  }

  void save(List<Item> rubbish) async {
    int numberOfRows = 0;

    _databaseFile = await openDatabase(_databaseFilename);
    numberOfRows = Sqflite.firstIntValue(
        await _databaseFile.rawQuery('SELECT COUNT(*) FROM  $_tableName'));

    if (numberOfRows == 0) {
      rubbish.forEach((item) {
        _databaseFile.insert(_tableName,
            {'id': item.uniqueId, 'numberInRubbish': item.numberInRubbish});
      });
    } else {
      // rubbish.forEach((item) {
      //   _databaseFile.update(_tableName, );
      // });
    }
    await _databaseFile.close();
  }

  Future<bool> exists() async {
    if (await databaseExists(_databaseFilename)) {
      return true;
    }
    return false;
  }
}
