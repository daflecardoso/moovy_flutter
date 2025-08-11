import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

enum DBTables {
  movements('movements');

  final String name;

  const DBTables(this.name);

  String get createTableQuery => switch (this) {
        movements => '''
  CREATE TABLE movements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT NOT NULL,
    amount REAL NOT NULL,
    incomeDate TEXT NOT NULL,
    dueDate TEXT NOT NULL,
    startDate TEXT NOT NULL,
    endDate TEXT NOT NULL,
    type TEXT NOT NULL
  )
  ''',
      };
}

class DB {
  Database? _db;

  Future<Database> get db async => _db ??= await _init();

  Future<Database> _init() async {
    return await openDatabase(
      'moovy.db',
      version: 1,
      onOpen: (db) async {
        debugPrint('🎲 Database opened successfully ${db.path}');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        debugPrint('🎲 Database upgraded from $oldVersion to $newVersion');
        for (final table in DBTables.values) {
          await db.execute('DROP TABLE IF EXISTS ${table.name}');
        }
        for (final table in DBTables.values) {
          await db.execute(table.createTableQuery);
        }
      },
      onDowngrade: (db, oldVersion, newVersion) async {
        debugPrint('🎲 Database downgraded from $oldVersion to $newVersion');
      },
      onCreate: (db, version) async {
        for (final table in DBTables.values) {
          await db.execute(table.createTableQuery);
        }
      },
    );
  }

  Future<void> upsert(String table, Map<String, dynamic> data) async {
    final db = await this.db;
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(String table, int id) async {
    final db = await this.db;
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await this.db;
    await db.close();
    _db = null;
  }
}
