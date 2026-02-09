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
      id TEXT NOT NULL,
      firestore_id TEXT,
      description TEXT NOT NULL,
      amount INTEGER NOT NULL,
      income_day INTEGER, 
      due_day INTEGER, 
      start_date DATETIME NOT NULL, 
      end_date DATETIME,
      start_ym INTEGER NOT NULL,
      end_ym INTEGER,
      type TEXT NOT NULL,
      paid BOOLEAN,
      image_url TEXT,
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
        // Step 1: Copy data from tables, retaining old table column info
        final Map<String, List<Map<String, dynamic>>> backupData = {};
        final Map<String, List<String>> tableColumns = {};
        for (final table in AppDatabaseTable.values) {
          // Get column info before dropping
          final columnInfo = await db.rawQuery('PRAGMA table_info(${table.tableName});');
          tableColumns[table.tableName] = columnInfo.map((e) => e['name'] as String).toList();
          backupData[table.tableName] = await db.query(table.tableName);
        }

        // Step 2: Drop tables
        for (final table in AppDatabaseTable.values) {
          await db.execute(table.dropTable);
        }

        // Step 3: Recreate tables
        for (final table in AppDatabaseTable.values) {
          await db.execute(table.createTable);
        }

        // Step 4: Restore data (only columns that exist in new schema)
        for (final table in AppDatabaseTable.values) {
          // Get new table columns
          final newColumnInfo = await db.rawQuery('PRAGMA table_info(${table.tableName});');
          final newColumns = newColumnInfo.map((e) => e['name'] as String).toSet();

          final data = backupData[table.tableName] ?? [];
          for (final row in data) {
            // Only keep keys present in new table
            final insertRow = <String, dynamic>{};
            for (final column in row.keys) {
              if (newColumns.contains(column)) {
                insertRow[column] = row[column];
              }
            }
            // Note: Optionally remove 'id' if not wanting to increase id number; currently preserves IDs
            await db.insert(table.tableName, insertRow);
          }
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
