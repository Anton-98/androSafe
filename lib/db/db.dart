import 'package:safe_droid/db/database_service.dart';
import 'package:safe_droid/models/appli.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  final tableName = 'app';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
          "id" INTEGER NOT NULL,
          "appName" TEXT NOT NULL,
          "url" TEXT,
          "version" TEXT NOT NULL,
          "certificat" REAL,
          "manifest" REAL,
          "networkSecu" REAL,
          "codeAnalyst" REAL,
          "scoreSecu" REAL,
          "permission" REAL,
          PRIMARY KEY('id' AUTOINCREMENT)
           );""");
  }

  Future<int> create({
    required String appName,
    String? url,
    required String version,
    required double certificat,
    required double manifest,
    required double networkSecu,
    required double codeAnalyst,
    required double scoreSecu,
    required double permission,
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert("""INSERT INTO $tableName (
         AppName,url,version,certificat,manifest,networkSecu,codeAnalyst,scoreSecu,permission) 
         values(?,?,?,?,?,?,?,?,?);""", [
      appName,
      url,
      version,
      certificat,
      manifest,
      networkSecu,
      codeAnalyst,
      scoreSecu,
      permission
    ]);
  }

  Future<List<AppAnalyse>> fetchAll() async {
    final database = await DatabaseService().database;
    final apps = await database.rawQuery('''SELECT * FROM $tableName ''');
    return apps.map((app) => AppAnalyse.fromSqfliteDataBase(app)).toList();
  }
}
