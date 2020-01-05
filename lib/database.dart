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
              .rawQuery('SELECT * FROM $_tableName WHERE id = ${item.uniqueId}')
              .then((items) {
            try {
              item.numberInRubbish = items.single['numberInRubbish'];
            } on StateError {
              item.numberInRubbish = 0;
            }
          });
        } on DatabaseException {
          item.numberInRubbish = 0;
        }
      });
    });
    await _file.close();
    return rubbish;
  }

  void save(List<Item> rubbish) async {
    void insertItems(Database db, List<Item> rubbish, int startIndex) {
      rubbish.sort((a, b) => a.uniqueId.compareTo(b.uniqueId));
      for (int i = startIndex; i < rubbish.length; i++) {
        try {
          db.rawInsert('INSERT INTO $_tableName(numberInRubbish) '
              'VALUES(${rubbish[i].numberInRubbish})');
        } on DatabaseException {
          continue;
        }
      }
    }

    _file = await openDatabase(await filename, onOpen: (db) async {
      final int numberOfRows = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM  $_tableName'));

      if (numberOfRows == 0) {
        insertItems(db, rubbish, 0);
      } else if (numberOfRows < rubbish.length) {
        insertItems(db, rubbish, numberOfRows);
      } else if (rubbish.length < numberOfRows) {
        rubbish.sort((a, b) => a.uniqueId.compareTo(b.uniqueId));
        for (int id = rubbish.length + 1; id <= numberOfRows; id++) {
          try {
            db.rawDelete('DELETE FROM $_tableName WHERE ID = $id');
          } on DatabaseException {
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
