import 'package:floor/floor.dart';
import 'package:moovy/database/domain/movement.dart';

@dao
abstract class MovementDao {
  @Query('SELECT * FROM Movement')
  Future<List<Movement>> findAll();

  @Query('SELECT * FROM Movement WHERE id = :id')
  Future<Movement?> findById(int id);

  @Query("""
  SELECT *
  FROM Movement
  WHERE :dateTime
  BETWEEN strftime('%Y-%m', startDate / 1000, 'unixepoch')
  AND COALESCE(strftime('%Y-%m', endDate / 1000, 'unixepoch'), '9999-12');
  """)
  Future<List<Movement>> findByMonthYear(String dateTime);

  @insert
  Future<void> insertMovement(Movement movement);

  @update
  Future<void> updateMovement(Movement movement);

  @Query('DELETE FROM Movement WHERE id = :id')
  Future<void> deleteById(int id);
}
