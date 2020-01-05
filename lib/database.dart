import 'package:sqflite/sqflite.dart';
import 'item.dart';

class Db {
  static const String _name = 'rubbish_calc.db';
  static const String _itemsTableName = 'Items';
  static const String _dateTableName = 'Date';
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
      const String idSql = 'id INTEGER NOT NULL PRIMARY KEY';

      db
          .execute('CREATE TABLE $_itemsTableName('
              '$idSql, numberInRubbish INTEGER NOT NULL)')
          .then((_) {
        db.execute(
            'CREATE TABLE $_dateTableName($idSql, appInitDate TEXT NOT NULL)');
      });
    });
    await _file.close();
  }

  Future<List<Item>> read(List<Item> rubbish) async {
    _file = await openDatabase(await filename, onOpen: (db) {
      rubbish.forEach((item) {
        try {
          db
              .rawQuery(
                  'SELECT * FROM $_itemsTableName WHERE id = ${item.uniqueId}')
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

  Future<String> readDate(String appInitDate, String currentDate) async {
    _file = await openDatabase(await filename, onOpen: (db) {
      try {
        db.rawQuery('SELECT * FROM $_dateTableName WHERE id = 1').then((date) {
          try {
            appInitDate = date.single['appInitDate'];
          } on StateError {
            appInitDate = currentDate;
          }
        });
      } on DatabaseException {
        appInitDate = currentDate;
      }
    });
    await _file.close();
    return appInitDate;
  }

  void save(List<Item> rubbish, String date) async {
    void insertItems(Database db, List<Item> rubbish, int startIndex) {
      rubbish.sort((a, b) => a.uniqueId.compareTo(b.uniqueId));
      for (int i = startIndex; i < rubbish.length; i++) {
        try {
          db.rawInsert('INSERT INTO $_itemsTableName(numberInRubbish) '
              'VALUES(${rubbish[i].numberInRubbish})');
        } on DatabaseException {
          db.rawInsert(
              'INSERT INTO $_itemsTableName(numberInRubbish) VALUES(0)');
        }
      }
    }

    _file = await openDatabase(await filename, onOpen: (db) async {
      int numberOfRows = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM  $_itemsTableName'));

      if (numberOfRows == 0) {
        insertItems(db, rubbish, 0);
      } else if (numberOfRows < rubbish.length) {
        insertItems(db, rubbish, numberOfRows);
      } else if (rubbish.length < numberOfRows) {
        rubbish.sort((a, b) => a.uniqueId.compareTo(b.uniqueId));
        for (int id = rubbish.length + 1; id <= numberOfRows; id++) {
          try {
            db.rawDelete('DELETE FROM $_itemsTableName WHERE ID = $id');
          } on DatabaseException {
            continue;
          }
        }
      } else {
        rubbish.forEach((item) {
          db.rawUpdate('UPDATE $_itemsTableName '
              'SET numberInRubbish = ${item.numberInRubbish} '
              'WHERE id = ${item.uniqueId}');
        });
      }

      numberOfRows = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM  $_dateTableName'));

      if (numberOfRows == 0) {
        db.rawInsert(
            'INSERT INTO $_dateTableName(appInitDate) VALUES("$date")');
      } else {
        db.rawUpdate(
            'UPDATE $_dateTableName SET appInitDate = "$date" WHERE id = 1');
      }
    });
    await _file.close();
  }
}
