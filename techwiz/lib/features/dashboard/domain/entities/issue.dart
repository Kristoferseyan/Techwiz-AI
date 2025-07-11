class Issue {
  final String id;
  final String title;
  final String description;
  final String difficulty;
  final String estimatedTime;
  final double rating;
  final String category;
  final DateTime createdAt;

  const Issue({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.estimatedTime,
    required this.rating,
    required this.category,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Issue &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.difficulty == difficulty &&
        other.estimatedTime == estimatedTime &&
        other.rating == rating &&
        other.category == category &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        difficulty.hashCode ^
        estimatedTime.hashCode ^
        rating.hashCode ^
        category.hashCode ^
        createdAt.hashCode;
  }
}
