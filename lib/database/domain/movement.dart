import 'package:floor/floor.dart';

@entity
class Movement {
  @primaryKey
  final int? id;
  final String description;
  final int amount;
  final DateTime? incomeDate, dueDate, startDate, endDate;
  final MovementType type;

  Movement({
    required this.id,
    required this.description,
    required this.amount,
    required this.incomeDate,
    required this.dueDate,
    required this.startDate,
    required this.endDate,
    required this.type,
  });

  @override
  String toString() {
    return description;
  }
}

enum MovementType {
  expense, income;

  static MovementType fromName(String name) {
    return MovementType.values.firstWhere((e) => e.name == name);
  }
}
