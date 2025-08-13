import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

enum AppDatabaseTable {
  movement('movement');

  final String tableName;
  const AppDatabaseTable(this.tableName);

  String get createTable => switch (this) {
    AppDatabaseTable.movement =>
      '''
    CREATE TABLE IF NOT EXISTS $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT NOT NULL,
      amount INTEGER NOT NULL,
      income_date DATETIME, 
      due_date DATETIME, 
      start_date DATETIME NOT NULL, 
      end_date DATETIME,
      type TEXT NOT NULL,
      paid BOOLEAN,
      created_at DATETIME NOT NULL,
      updated_at DATETIME NOT NULL
    )
    ''',
  };

  String get dropTable => 'DROP TABLE IF EXISTS $tableName';
}

@injectable
class AppDatabase {
  static const databaseName = 'moovy.db';
  Database? _sqlite;

  Future<Database> get sqlite async {
    if (_sqlite != null) return _sqlite!;
    _sqlite = await _openDatabase();
    return _sqlite!;
  }

  Future<Database> _openDatabase() async {
    return await openDatabase(
      databaseName,
      version: 1,
      onOpen: (db) async {
        debugPrint('✅ onOpen: ${db.path}');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        debugPrint('✅ onUpgrade: ${db.path}, from: $oldVersion to: $newVersion');
        for (final table in AppDatabaseTable.values) {
          await db.execute(table.dropTable);
        }
        for (final table in AppDatabaseTable.values) {
          await db.execute(table.createTable);
        }
      },
      onCreate: (db, version) async {
        debugPrint('✅ onCreate: ${db.path}');
        for (final table in AppDatabaseTable.values) {
          await db.execute(table.createTable);
        }
      },
    );
  }

  Future<int> insert(AppDatabaseTable table, Map<String, dynamic> values) async {
    final db = await sqlite;
    return await db.insert(table.tableName, values);
  }

  Future<int> update(AppDatabaseTable table, Map<String, dynamic> values, {String? where, List<dynamic>? whereArgs}) async {
    final db = await sqlite;
    return await db.update(table.tableName, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(AppDatabaseTable table, {String? where, List<dynamic>? whereArgs}) async {
    final db = await sqlite;
    return await db.delete(table.tableName, where: where, whereArgs: whereArgs);
  }
}
