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
    await _databaseFile.close();
  }

  Future<List<Item>> read(List<Item> rubbish) async {
    _databaseFile =
        await openDatabase(_databaseFilename, onOpen: (Database db) async {
      int numberOfRows = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM  $_tableName'));

      // if(numberOfRows != rubbish.length) {
      //   return rubbish;
      // }

      rubbish.forEach((item) {
        db
            .rawQuery('SELECT * FROM $_tableName '
                'WHERE id = ${item.uniqueId}')
            .then((dbItem) {
          item.numberInRubbish = dbItem[0]['numberInRubbish'];
          debugPrint(item.numberInRubbish.toString());
        });
      });
    });
    await _databaseFile.close();
    return rubbish;
  }

  void save(List<Item> rubbish) async {
    rubbish.sort((a, b) => a.uniqueId.compareTo(b.uniqueId));

    _databaseFile =
        await openDatabase(_databaseFilename, onOpen: (Database db) async {
      int numberOfRows = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM  $_tableName'));

      try {
        if (numberOfRows == 0) {
          rubbish.forEach((item) {
            db.rawInsert('INSERT INTO $_tableName(id, numberInRubbish) '
                'VALUES(${item.uniqueId}, ${item.numberInRubbish})');
          });
        } else {
          rubbish.forEach((item) {
            db.rawUpdate('UPDATE $_tableName '
                'SET numberInRubbish = ${item.numberInRubbish} '
                'WHERE id = ${item.uniqueId}');
          });
        }
      } catch (DatabaseException) {
        debugPrint('UNIQUE constraint failed - repeated ID');
      }
    });
    await _databaseFile.close();
  }

  Future<bool> exists() async {
    if (await databaseExists(_databaseFilename)) {
      return true;
    }
    return false;
  }
}
