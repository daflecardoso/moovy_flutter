
import 'package:moovy/database/database.dart';
import 'package:sqflite/sqlite_api.dart';

class FakeAppDataBase implements AppDatabase {
  @override
  Future<int> delete(AppDatabaseTable table, {String? where, List<dynamic>? whereArgs}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<int> insert(AppDatabaseTable table, Map<String, dynamic> values) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  // TODO: implement sqlite
  Future<Database> get sqlite => throw UnimplementedError();

  @override
  Future<int> update(AppDatabaseTable table, Map<String, dynamic> values, {String? where, List<dynamic>? whereArgs}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}