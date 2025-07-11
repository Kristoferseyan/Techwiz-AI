class Guide {
  final String id;
  final String title;
  final String iconName;
  final String duration;
  final String category;
  final DateTime createdAt;

  const Guide({
    required this.id,
    required this.title,
    required this.iconName,
    required this.duration,
    required this.category,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Guide &&
        other.id == id &&
        other.title == title &&
        other.iconName == iconName &&
        other.duration == duration &&
        other.category == category &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        iconName.hashCode ^
        duration.hashCode ^
        category.hashCode ^
        createdAt.hashCode;
  }
}
