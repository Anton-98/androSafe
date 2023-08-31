import 'dart:async';

import 'package:safe_droid/db/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'base.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var db = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return db;
  }

  Future<void> create(Database db, int version) async =>
      await DB().createTable(db);
}
