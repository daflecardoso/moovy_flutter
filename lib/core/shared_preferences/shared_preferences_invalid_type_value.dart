
class SharedPreferencesInvalidValueType implements Exception {
  final String message;
  final String? code;

  SharedPreferencesInvalidValueType(this.message, {this.code});

  @override
  String toString() {
    return 'Invalid type exception. $message';
  }
}