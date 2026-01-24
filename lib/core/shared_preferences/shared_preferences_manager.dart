import 'package:injectable/injectable.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_invalid_type_value.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPreferencesManager {
  Future<void> set({required SharedPreferencesKey key, dynamic value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key.name, value);
    } else if (value is bool) {
      prefs.setBool(key.name, value);
    } else if (value is double) {
      prefs.setDouble(key.name, value);
    } else if (value is String) {
      prefs.setString(key.name, value);
    } else if (value is List<String>) {
      prefs.setStringList(key.name, value);
    } else {
      throw SharedPreferencesInvalidValueType('${value.runtimeType} is not compatible.');
    }
  }

  Future<T?> get<T>({required SharedPreferencesKey key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key.name) as T?;
  }

  Future<void> delete({required SharedPreferencesKey key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key.name);
  }
}
