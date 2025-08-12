import 'package:floor/floor.dart';
import 'package:moovy/database/domain/movement.dart';

@dao
abstract class MovementDao {
  @Query('SELECT * FROM Movement')
  Future<List<Movement>> findAll();

  @Query('SELECT * FROM Movement WHERE id = :id')
  Stream<Movement?> findById(int id);

  @Query("""
  SELECT *
  FROM Movement
  WHERE strftime('%Y-%m', startDate / 1000, 'unixepoch') <= :dateTime
  AND strftime('%Y-%m', endDate / 1000, 'unixepoch') >= :dateTime
  """)
  Future<List<Movement>> findByMonthYear(String dateTime);

  @insert
  Future<void> insertMovement(Movement movement);
}
