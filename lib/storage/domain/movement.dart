import 'dart:convert';

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

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'amount': amount,
    'incomeDate': incomeDate?.toString(),
    'dueDate': dueDate?.toString(),
    'startDate': startDate?.toString(),
    'endDate': endDate?.toString(),
    'type': type
  };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

enum MovementType {
  expense, income;

  static MovementType fromName(String name) {
    return MovementType.values.firstWhere((e) => e.name == name);
  }
}
