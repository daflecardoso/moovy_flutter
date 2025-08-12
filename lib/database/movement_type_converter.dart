import 'package:floor/floor.dart';
import 'package:moovy/database/domain/movement.dart';

class MovementTypeConverter extends TypeConverter<MovementType?, String?> {
  @override
  MovementType? decode(String? databaseValue) {
    return databaseValue == null ? null : MovementType.values.byName(databaseValue);
  }

  @override
  String? encode(MovementType? value) {
    return value?.name;
  }
}