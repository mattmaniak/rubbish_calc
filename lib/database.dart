import 'package:sqflite/sqflite.dart';

import 'item.dart';

class Db {
  // static final Db _singleton = Db._internal();

  static const String _name = 'rubbish_calc.db';
  static const String _rubbishTableName = 'Rubbish';
  static const String _dateTableName = 'Date';
  Database _file;

  Future<String> get _filename async => await getDatabasesPath() + '/' + _name;

  Future<bool> get exists async {
    if (await databaseExists(await _filename)) {
      return true;
    }
    return false;
  }

  // factory Db() => _singleton;
  // Db._internal();

  Future<void> create() async {
    _file = await openDatabase(await _filename, version: 1,
        onCreate: (db, version) {
      const String idSql = 'id INTEGER NOT NULL PRIMARY KEY';

      db.execute('CREATE TABLE IF NOT EXISTS $_rubbishTableName('
          '$idSql, numberInRubbish INTEGER NOT NULL)');
      db.execute('CREATE TABLE IF NOT EXISTS $_dateTableName('
          '$idSql, appInitDate TEXT NOT NULL)');
    });
    await _file.close();
  }

  Future<List<Item>> loadRubbish(List<Item> rubbish) async {
    _file = await openDatabase(await _filename, onOpen: (db) {
      rubbish.forEach((item) {
        try {
          db.rawQuery('SELECT * FROM $_rubbishTableName WHERE id = ?',
              [item.uniqueId]).then((items) {
            if (items.isNotEmpty) {
              try {
                item.numberInRubbish = items.single['numberInRubbish'];
              } on StateError {
                item.numberInRubbish = 0;
              }
            } else {
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

  Future<String> loadAppInitDate(String appInitDate, String currentDate) async {
    _file = await openDatabase(await _filename, onOpen: (db) async {
      try {
        var date = await db
            .rawQuery('SELECT * FROM $_dateTableName WHERE id = ?', [1]);
        if (date.isNotEmpty) {
          try {
            appInitDate = date.single['appInitDate'];
          } on StateError {
            appInitDate = currentDate;
          }
        }
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
          db.rawInsert(
              'INSERT INTO $_rubbishTableName(numberInRubbish) VALUES(?)',
              [rubbish[i].numberInRubbish]);
        } on DatabaseException {
          db.rawInsert(
              'INSERT INTO $_rubbishTableName(numberInRubbish) VALUES(0)');
        }
      }
    }

    _file = await openDatabase(await _filename, onOpen: (db) async {
      int numberOfRows = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $_rubbishTableName'));

      if (numberOfRows == 0) {
        insertItems(db, rubbish, 0);
      } else if (numberOfRows < rubbish.length) {
        insertItems(db, rubbish, numberOfRows);
      } else if (rubbish.length < numberOfRows) {
        rubbish.sort((a, b) => a.uniqueId.compareTo(b.uniqueId));
        for (int id = rubbish.length + 1; id <= numberOfRows; id++) {
          try {
            db.rawDelete('DELETE FROM $_rubbishTableName WHERE ID = ?', [id]);
          } on DatabaseException {
            continue;
          }
        }
      } else {
        rubbish.forEach((item) {
          db.rawUpdate(
              'UPDATE $_rubbishTableName SET numberInRubbish = ? WHERE id = ?',
              [item.numberInRubbish, item.uniqueId]);
        });
      }

      numberOfRows = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $_dateTableName'));

      if (numberOfRows == 0) {
        db.rawInsert(
            'INSERT INTO $_dateTableName(appInitDate) VALUES(?)', [date]);
      } else {
        db.rawUpdate(
            'UPDATE $_dateTableName SET appInitDate = ? WHERE id = 1', [date]);
      }
    });
    await _file.close();
  }
}
