import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {
  static final DataBaseProvider dbProvider = DataBaseProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await createDataBase();
  }

  createDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "testsql.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }
  Future initDB(Database database, int version) async {
    return await database.execute("CREATE TABLE student ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT, "
        "mobile_no TEXT "
        ")");
  }
}