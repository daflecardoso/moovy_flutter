// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movement _$MovementFromJson(Map<String, dynamic> json) => Movement(
  id: (json['id'] as num?)?.toInt(),
  firestoreId: json['firestore_id'] as String?,
  description: json['description'] as String,
  amount: (json['amount'] as num).toInt(),
  dueDay: (json['due_day'] as num?)?.toInt(),
  incomeDay: (json['income_day'] as num?)?.toInt(),
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  paid: const BoolFlexConverter().fromJson(json['paid']),
  imageUrl: json['image_url'] as String?,
  type: $enumDecode(_$MovementTypeEnumMap, json['type']),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$MovementToJson(Movement instance) => <String, dynamic>{
  'id': instance.id,
  'firestore_id': instance.firestoreId,
  'description': instance.description,
  'amount': instance.amount,
  'due_day': instance.dueDay,
  'income_day': instance.incomeDay,
  'start_date': instance.startDate.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'end_date': instance.endDate?.toIso8601String(),
  'paid': const BoolFlexConverter().toJson(instance.paid),
  'image_url': instance.imageUrl,
  'type': _$MovementTypeEnumMap[instance.type]!,
};

const _$MovementTypeEnumMap = {
  MovementType.expense: 'expense',
  MovementType.income: 'income',
};
