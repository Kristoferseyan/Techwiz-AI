class Category {
  final String name;
  final String? description;

  const Category({required this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'] ?? '', description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode {
    return name.hashCode ^ description.hashCode;
  }
}
