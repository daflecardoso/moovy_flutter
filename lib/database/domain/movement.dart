
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
