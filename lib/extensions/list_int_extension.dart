
extension ListExtension on List<int> {

  int get sum => isNotEmpty ? reduce((a, b) => a + b) : 0;
}