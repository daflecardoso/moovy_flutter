
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:moovy/database/bool_flex_converter.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/income_expense/occurrence.dart';

part 'movement.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movement {
  final String? id;
  final String? firestoreId;
  final String description;
  final int amount;
  final int? dueDay, incomeDay;
  final DateTime startDate, createdAt, updatedAt;
  final DateTime? endDate;
  final int startYm;
  final int? endYm;
  @BoolFlexConverter()
  bool paid;
  final String? imageUrl;
  final MovementType type;

  Movement({
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
    required this.imageUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt
  });

  Movement copyWith({
    String? id,
    String? firestoreId,
    String? description,
    int? amount,
    int? dueDay,
    int? incomeDay,
    DateTime? startDate,
    DateTime? endDate,
    int? startYm,
    int? endYm,
    bool? paid,
    MovementType? type,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Movement(
      id: id,
      firestoreId: firestoreId ?? this.firestoreId,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      dueDay: dueDay ?? this.dueDay,
      incomeDay: incomeDay ?? this.incomeDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startYm: startYm ?? this.startYm,
      endYm: endYm ?? this.endYm,
      paid: paid ?? this.paid,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
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

  Occurrence getOccurrence() {
    return isSameMonthYear() ? .it : .all;
  }

  int getDay() {
    switch (type) {
      case MovementType.income:
        return incomeDay!;
      case MovementType.expense:
       return dueDay!;
    }
  }
}

enum MovementType {
  income, expense;

  Color get color => switch(this) {
    MovementType.expense => Colors.pink,
    MovementType.income => Colors.green
  };

  static MovementType fromName(String name) {
    return MovementType.values.firstWhere((e) => e.name == name);
  }
}
