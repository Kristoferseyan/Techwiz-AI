class Solution {
  final int id;
  final String title;
  final String description;

  const Solution({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Solution &&
        other.id == id &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode;
  }
}
