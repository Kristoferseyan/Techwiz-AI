class MatchedProblem {
  final int id;
  final String name;

  const MatchedProblem({required this.id, required this.name});

  factory MatchedProblem.fromJson(Map<String, dynamic> json) {
    return MatchedProblem(id: json['id'] as int, name: json['name'] as String);
  }
}
