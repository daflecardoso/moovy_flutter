import 'package:injectable/injectable.dart';
import 'package:moovy/database/database.dart';
import 'package:moovy/database/domain/movement/movement.dart';

@injectable
class MovementDao {
  AppDatabase appDatabase;
  MovementDao(this.appDatabase);

  Future<List<Movement>> findAll() async {
    final sqlite = await appDatabase.sqlite;
    final movements = await sqlite.rawQuery('SELECT * FROM Movement');
    return movements.map((item) => Movement.fromJson(item)).toList();
  }

  Future<Movement?> findById(int id) async {
    final sqlite = await appDatabase.sqlite;
    final movements = await sqlite.rawQuery('SELECT * FROM Movement WHERE id = $id');
    if (movements.firstOrNull case final movement?) {
      return Movement.fromJson(movement);
    }
    return null;
  }

  Future<List<Movement>> findByMonthYear(String dateTime) async {
    final sqlite = await appDatabase.sqlite;
    final movements = await sqlite.rawQuery(''' 
    SELECT *
    FROM Movement
    WHERE '$dateTime'
    BETWEEN strftime('%Y-%m', start_date)
    AND COALESCE(strftime('%Y-%m', end_date), '9999-12')
    ORDER BY due_day, income_day
    ''');
    return movements.map((item) => Movement.fromJson(item)).toList();
  }

  Future<void> insertMovement(Movement movement) async {
    await appDatabase.insert(AppDatabaseTable.movement, movement.toJSON());
  }

  Future<int> updateMovement(Movement movement) async {
    return await appDatabase.update(AppDatabaseTable.movement, movement.toJSON(), where: 'id = ?', whereArgs: [movement.id]);
  }

  Future<void> deleteById(int id) async {
    await appDatabase.delete(AppDatabaseTable.movement, where: 'id = ?', whereArgs: [id]);
  }
}
