
extension StringExtensions on String {

  String digits() => replaceAll(RegExp(r'[^0-9]'), '');

  int toInt() => int.parse(this);
}