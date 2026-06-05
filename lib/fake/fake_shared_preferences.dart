
import 'package:moovy/core/shared_preferences/shared_preferences_key.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';

class FakeSharedPreferences implements SharedPreferencesManager {
  @override
  Future<void> delete({required SharedPreferencesKey key}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<T?> get<T>({required SharedPreferencesKey key}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<void> set({required SharedPreferencesKey key, value}) {
    // TODO: implement set
    throw UnimplementedError();
  }
}