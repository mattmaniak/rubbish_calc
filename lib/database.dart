import 'package:sqflite/sqflite.dart';
import 'item.dart';

class Db {
  static const String _name = 'rubbish_calc.db';
  static const String _tableName = 'Items';
  Database _file;

  Future<String> get filename async => await getDatabasesPath() + '/' + _name;

  Future<bool> get exists async {
    if (await databaseExists(await filename)) {
      return true;
    }
    return false;
  }

  Future<void> create() async {
    _file =
        await openDatabase(await filename, version: 1, onCreate: (db, version) {
      db.execute('CREATE TABLE $_tableName('
          'id INTEGER NOT NULL PRIMARY KEY,'
          'numberInRubbish INTEGER NOT NULL)');
    });
    await _file.close();
  }

  Future<List<Item>> read(List<Item> rubbish) async {
    _file = await openDatabase(await filename, onOpen: (db) {
      rubbish.forEach((item) {
        try {
          db
              .rawQuery('SELECT * FROM $_tableName '
                  'WHERE id = ${item.uniqueId}')
              .then((dbItems) {
            if (dbItems.length > 0) {
              item.numberInRubbish = dbItems.first['numberInRubbish'];
            } else {
              item.numberInRubbish = 0;
            }
          });
        } catch (DatabaseException) {
          item.numberInRubbish = 0;
        }
      });
    });
    await _file.close();
    return rubbish;
  }

  void save(List<Item> rubbish) async {
    rubbish.sort((a, b) => a.uniqueId.compareTo(b.uniqueId));

    _file = await openDatabase(await filename, onOpen: (db) async {
      int numberOfRows = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM  $_tableName'));

      if (numberOfRows == 0) {
        for (int i = 0; i < rubbish.length; i++) {
          try {
            db.rawInsert('INSERT INTO $_tableName(id, numberInRubbish) '
                'VALUES(${rubbish[i].uniqueId}, ${rubbish[i].numberInRubbish})');
          } catch (DatabaseException) {
            continue;
          }
        }
      } else {
        rubbish.forEach((item) {
          db.rawUpdate('UPDATE $_tableName '
              'SET numberInRubbish = ${item.numberInRubbish} '
              'WHERE id = ${item.uniqueId}');
        });
      }
    });
    await _file.close();
  }
}
