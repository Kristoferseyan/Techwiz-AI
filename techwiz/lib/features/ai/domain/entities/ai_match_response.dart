import 'matched_problem.dart';
import 'related_problem.dart';

class AiMatchResponse {
  final List<MatchedProblem> matchedProblems;
  final List<RelatedProblem> relatedProblems;

  const AiMatchResponse({
    required this.matchedProblems,
    required this.relatedProblems,
  });

  factory AiMatchResponse.fromJson(Map<String, dynamic> json) {
    return AiMatchResponse(
      matchedProblems:
          (json['matchedProblems'] as List<dynamic>?)
              ?.map((item) => MatchedProblem.fromJson(item))
              .toList() ??
          [],
      relatedProblems:
          (json['relatedProblems'] as List<dynamic>?)
              ?.map((item) => RelatedProblem.fromJson(item))
              .toList() ??
          [],
    );
  }
}
