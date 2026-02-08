import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/domain/movement/movement.dart';

@Injectable()
final class MovementRepository {
  MovementDao movementDao;
  MovementRepository(this.movementDao);

  Future<List<Movement>> findByMonthYear(String dateTime) async {
    return movementDao.findByMonthYear(dateTime);
  }

  Future<Movement?> findById(int id) async {
    return movementDao.findById(id);
  }

  Future<void> insertMovement(Movement movement) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final res = await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('movements').add(movement.toJSON());
      final move = movement.copyWith(firestoreId: res.id);
      return movementDao.insertMovement(move);
    }
    return movementDao.insertMovement(movement);
  }

  Future<int> updateMovement(Movement movement) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('movements')
          .doc(movement.firestoreId)
          .update(movement.toJSON());
    }
    return movementDao.updateMovement(movement);
  }

  Future<void> deleteById(int id) async {
    await movementDao.deleteById(id);
  }
}
