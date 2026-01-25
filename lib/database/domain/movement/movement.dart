
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:moovy/database/bool_flex_converter.dart';
import 'package:moovy/extensions/int_extensions.dart';

part 'movement.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movement {
  final int? id;
  final String description;
  final int amount;
  final int? dueDay, incomeDay;
  final DateTime startDate, createdAt, updatedAt;
  final DateTime? endDate;
  @BoolFlexConverter()
  bool paid;
  final MovementType type;

  Movement({
    required this.id,
    required this.description,
    required this.amount,
    required this.dueDay,
    required this.incomeDay,
    required this.startDate,
    required this.endDate,
    required this.paid,
    required this.type,
    required this.createdAt,
    required this.updatedAt
  });

  Movement copyWith({
    int? id,
    String? description,
    int? amount,
    int? dueDay,
    int? incomeDay,
    DateTime? startDate,
    DateTime? endDate,
    bool? paid,
    MovementType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Movement(
      id: id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      dueDay: dueDay ?? this.dueDay,
      incomeDay: incomeDay ?? this.incomeDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      paid: paid ?? this.paid,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJSON() => _$MovementToJson(this);

  factory Movement.fromJson(Map<String, dynamic> json) => _$MovementFromJson(json);

  String get uiAmount {
    final signal = switch (type) {
      MovementType.expense => "-",
      MovementType.income => "+"
    };
    return "$signal ${amount.currency()}";
  }

  @override
  String toString() {
    return description;
  }

  bool isSameMonthYear() {
    if (endDate case final edt?) {
      return startDate.month == edt.month && startDate.year == edt.year;
    }
    return false;
  }
}

enum MovementType {
  expense, income;

  Color get color => switch(this) {
    MovementType.expense => Colors.redAccent,
    MovementType.income => Colors.green
  };

  static MovementType fromName(String name) {
    return MovementType.values.firstWhere((e) => e.name == name);
  }
}
