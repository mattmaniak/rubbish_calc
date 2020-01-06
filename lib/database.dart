import 'package:sqflite/sqflite.dart';

import 'item.dart';

class Db {
  static final Db _singleton = Db._internal();

  static const String _name = 'rubbish_calc.db';
  static const String _rubbishTableName = 'Rubbish';
  static const String _dateTableName = 'Date';
  Database _file;

  factory Db() => _singleton;
  Db._internal();

  Future<String> get _filename async => await getDatabasesPath() + '/' + _name;

  Future<bool> get exists async {
    if (await databaseExists(await _filename)) {
      return true;
    }
    return false;
  }

  Future<dynamic> _fetchValue(Database db, String sql, List<dynamic> args,
      String rowName, dynamic onErrorValue) async {
    dynamic value;
    try {
      var fetchedData = await db.rawQuery(sql, args);
      if (fetchedData.isNotEmpty) {
        try {
          value = fetchedData.single[rowName];
        } on StateError {
          value = 0;
        }
      } else {
        value = 0;
      }
    } on DatabaseException {
      value = 0;
    }
    if (value == null) {
      value = 0;
    }
    return value;
  }

  Future<void> create() async {
    _file = await openDatabase(await _filename, version: 1,
        onCreate: (db, version) {
      const String idSql = 'id INTEGER NOT NULL PRIMARY KEY';

      db.execute('CREATE TABLE IF NOT EXISTS $_rubbishTableName('
          '$idSql, numberInRubbish INTEGER NOT NULL)');
      db.execute('CREATE TABLE IF NOT EXISTS $_dateTableName('
          '$idSql, appInitDate TEXT NOT NULL)');
    });
    _file.close();
  }

  Future<List<Item>> loadRubbish(List<Item> rubbish) async {
    _file = await openDatabase(await _filename, onOpen: (db) {
      rubbish.forEach((item) async {
        item.numberInRubbish = await _fetchValue(
            db,
            'SELECT * FROM $_rubbishTableName WHERE id = ?',
            [item.uniqueId],
            'numberInRubbish',
            0);
      });
    });
    _file.close();
    return rubbish;
  }

  Future<String> loadAppInitDate(String appInitDate, String currentDate) async {
    _file = await openDatabase(await _filename, onOpen: (db) async {
      appInitDate = await _fetchValue(
          db,
          'SELECT * FROM $_dateTableName WHERE id = ?',
          [1],
          'appInitDate',
          currentDate);
    });
    _file.close();
    return appInitDate;
  }

  void save(List<Item> rubbish, String date) async {
    _file = await openDatabase(await _filename, onOpen: (db) async {
      int numberOfRows = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $_rubbishTableName'));

      void insertItems(int startIndex) {
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

      if (numberOfRows == 0) {
        insertItems(0);
      } else if (numberOfRows < rubbish.length) {
        insertItems(numberOfRows);
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
    _file.close();
  }
}
