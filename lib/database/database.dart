import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/date_time_converter.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/database/movement_type_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@TypeConverters([DateTimeConverter, MovementTypeConverter])
@Database(version: 1, entities: [Movement])
abstract class AppDatabase extends FloorDatabase {
  MovementDao get movementDao;
}

@injectable
class DatabaseInstance {
  final _db = $FloorAppDatabase.databaseBuilder('moovy.db').build();

  Future<AppDatabase> get() async {
    final db = await _db;
    debugPrint("✅ ${db.database.database.path}");
    return db;
  }

  Future<void> close() async {
    final db = await _db;
    await db.close();
  }
}
