import 'package:floor/floor.dart';
import 'package:moovy/core/movement_type_converter.dart';

@entity
class Movement {
  @primaryKey
  final int id;
  final String description;
  final int amount;
  final DateTime incomeDate;
  final DateTime dueDate;
  final DateTime startDate;
  final DateTime endDate;
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
}

enum MovementType { income, expense }
