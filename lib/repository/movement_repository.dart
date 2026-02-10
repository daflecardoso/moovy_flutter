import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/extensions/string_extensions.dart';

@Injectable()
final class MovementRepository {
  MovementDao movementDao;
  MovementRepository(this.movementDao);

  final _usersTable = 'users';
  final _movementsTable = 'movements';

  Future<List<Movement>> findByMonthYear(String dateTime) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final qStart = FirebaseFirestore.instance
          .collection(_usersTable)
          .doc(user.uid)
          .collection(_movementsTable)
          .where('start_ym', isLessThanOrEqualTo: dateTime.digits().toInt())
          .get();
      final qEnd = FirebaseFirestore.instance
          .collection(_usersTable)
          .doc(user.uid)
          .collection(_movementsTable)
          .where('end_ym', isGreaterThanOrEqualTo: dateTime.digits().toInt())
          .get();
      final snapStart = await qStart;
      final snapEnd = await qEnd;

      final Map<String, QueryDocumentSnapshot> startMap = {for (final d in snapStart.docs) d.id: d};

      final merged = snapEnd.docs.where((d) => startMap.containsKey(d.id)).toList();

      return merged.map((doc) => Movement.fromJson(doc.data())).toList();
    }

    return movementDao.findByMonthYear(dateTime);
  }

  Future<Movement?> findById(String id) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final db = await movementDao.findById(id);
        if (db != null) {
          final snapshot = await FirebaseFirestore.instance
              .collection(_usersTable)
              .doc(user.uid)
              .collection(_movementsTable)
              .doc(db.firestoreId)
              .get();
          final data = snapshot.data();
          if (data != null) {
            return Movement.fromJson(data);
          }
        }
      }
      return movementDao.findById(id);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> insertMovement(Movement movement) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final res = await FirebaseFirestore.instance
          .collection(_usersTable)
          .doc(user.uid)
          .collection(_movementsTable)
          .add(movement.toJSON());
      final move = movement.copyWith(id: movement.id, firestoreId: res.id);
      await FirebaseFirestore.instance
          .collection(_usersTable)
          .doc(user.uid)
          .collection(_movementsTable)
          .doc(res.id)
          .update(move.toJSON());
      return movementDao.insertMovement(move);
    }
    return movementDao.insertMovement(movement);
  }

  Future<int> updateMovement(Movement movement) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection(_usersTable)
          .doc(user.uid)
          .collection(_movementsTable)
          .doc(movement.firestoreId)
          .update(movement.toJSON());
    }
    return await movementDao.updateMovement(movement);
  }

  Future<void> deleteById(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    final movement = await findById(id);
    if (user != null && movement != null) {
      await FirebaseFirestore.instance
          .collection(_usersTable)
          .doc(user.uid)
          .collection(_movementsTable)
          .doc(movement.firestoreId)
          .delete();
    }
    await movementDao.deleteById(id);
  }
}
