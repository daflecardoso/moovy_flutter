import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/database.dart';
import 'package:moovy/database/domain/movement/movement.dart';

class FakeMovementDao implements MovementDao {
  @override
  late AppDatabase appDatabase;

  @override
  Future<void> deleteById(String id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<List<Movement>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Movement?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<List<Movement>> findByMonthYear(String dateTime) async {
    throw UnimplementedError();
  }

  @override
  Future<void> insertMovement(Movement movement) {
    // TODO: implement insertMovement
    throw UnimplementedError();
  }

  @override
  Future<int> updateMovement(Movement movement) {
    // TODO: implement updateMovement
    throw UnimplementedError();
  }
}
