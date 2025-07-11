class QuickAction {
  final String id;
  final String title;
  final String subtitle;
  final String iconName;
  final String colorCode;
  final String route;

  const QuickAction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconName,
    required this.colorCode,
    required this.route,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuickAction &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.iconName == iconName &&
        other.colorCode == colorCode &&
        other.route == route;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        iconName.hashCode ^
        colorCode.hashCode ^
        route.hashCode;
  }
}
