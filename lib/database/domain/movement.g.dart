// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movement _$MovementFromJson(Map<String, dynamic> json) => Movement(
  id: (json['id'] as num?)?.toInt(),
  description: json['description'] as String,
  amount: (json['amount'] as num).toInt(),
  incomeDate:
      json['income_date'] == null
          ? null
          : DateTime.parse(json['income_date'] as String),
  dueDate:
      json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
  startDate: DateTime.parse(json['start_date'] as String),
  endDate:
      json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
  paid: const BoolFlexConverter().fromJson(json['paid']),
  type: $enumDecode(_$MovementTypeEnumMap, json['type']),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$MovementToJson(Movement instance) => <String, dynamic>{
  'id': instance.id,
  'description': instance.description,
  'amount': instance.amount,
  'income_date': instance.incomeDate?.toIso8601String(),
  'due_date': instance.dueDate?.toIso8601String(),
  'end_date': instance.endDate?.toIso8601String(),
  'start_date': instance.startDate.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'paid': const BoolFlexConverter().toJson(instance.paid),
  'type': _$MovementTypeEnumMap[instance.type]!,
};

const _$MovementTypeEnumMap = {
  MovementType.expense: 'expense',
  MovementType.income: 'income',
};
