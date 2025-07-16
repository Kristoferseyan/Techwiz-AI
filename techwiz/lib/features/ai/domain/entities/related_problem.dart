class RelatedProblem {
  final int id;
  final String name;

  const RelatedProblem({required this.id, required this.name});

  factory RelatedProblem.fromJson(Map<String, dynamic> json) {
    return RelatedProblem(id: json['id'] as int, name: json['name'] as String);
  }
}
