import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'item.dart';

class Db {
  static final String _name = 'rubbish_calc.db';
  final String _tableName = 'Items';
  Database _file;

  Future<String> get filename async {
    return await getDatabasesPath() + '/' + _name;
  }

  Future<bool> get exists async {
    if (await databaseExists(await filename)) {
      return true;
    }
    return false;
  }

  void create() async {
    _file = await openDatabase(await filename, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE $_tableName('
          'id INTEGER NOT NULL PRIMARY KEY,'
          'numberInRubbish INTEGER NOT NULL)');
    });
    await _file.close();
  }

  Future<List<Item>> read(List<Item> rubbish) async {
    _file = await openDatabase(await filename, onOpen: (Database db) async {
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
    await _file.close();
    return rubbish;
  }

  void save(List<Item> rubbish) async {
    rubbish.sort((a, b) => a.uniqueId.compareTo(b.uniqueId));

    _file = await openDatabase(await filename, onOpen: (Database db) async {
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
    await _file.close();
  }
}
