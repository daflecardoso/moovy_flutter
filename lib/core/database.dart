
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:moovy/core/date_time_converter.dart';
import 'package:moovy/core/movement_type_converter.dart';
import 'package:moovy/storage/dao/movement_dao.dart';
import 'package:moovy/storage/domain/movement.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@TypeConverters([DateTimeConverter, MovementTypeConverter])
@Database(version: 1, entities: [Movement])
abstract class AppDatabase extends FloorDatabase {
  MovementDao get movementDao;
}