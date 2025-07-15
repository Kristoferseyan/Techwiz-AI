class Solution {
  final String title;
  final String description;

  const Solution({required this.title, required this.description});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Solution &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode;
  }
}
