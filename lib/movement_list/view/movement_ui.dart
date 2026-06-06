import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/gen/assets.gen.dart';
import 'package:moovy/income_expense/occurrence.dart';

sealed class MovementImage {
  String? urlOrNull() {
    return (this as MovementImageUrl?)?.imageUrl;
  }
}

final class MovementImageUrl extends MovementImage {
  String? imageUrl;
  MovementImageUrl(this.imageUrl);
}

final class MovementImageAsset extends MovementImage {
  AssetGenImage? image;
  MovementImageAsset(this.image);
}

class MovementUi {
  final String? id;
  final String? firestoreId;
  final String description;
  final int amount;
  final int? dueDay, incomeDay;
  final DateTime startDate, createdAt, updatedAt;
  final DateTime? endDate;
  final int startYm;
  final int? endYm;
  bool paid;
  final MovementImage? image;
  final MovementType type;

  MovementUi({
    required this.id,
    required this.firestoreId,
    required this.description,
    required this.amount,
    required this.dueDay,
    required this.incomeDay,
    required this.startDate,
    required this.endDate,
    required this.startYm,
    required this.endYm,
    required this.paid,
    required this.image,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  String get uiAmount {
    final signal = switch (type) {
      MovementType.expense => "-",
      MovementType.income => "+"
    };
    return "$signal ${amount.currency()}";
  }

  bool isSameMonthYear() {
    if (endDate case final edt?) {
      return startDate.month == edt.month && startDate.year == edt.year;
    }
    return false;
  }

  Occurrence getOccurrence() {
    return isSameMonthYear() ? .it : .all;
  }

  Movement toMovement() {
    final img = image as MovementImageUrl?;
    return Movement(
      id: id,
      firestoreId: firestoreId,
      description: description,
      amount: amount,
      dueDay: dueDay,
      incomeDay: incomeDay,
      startDate: startDate,
      endDate: endDate,
      startYm: startYm,
      endYm: endYm,
      paid: paid,
      imageUrl: img?.imageUrl,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
