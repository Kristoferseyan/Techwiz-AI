import '../entities/ai_match_request.dart';
import '../entities/ai_match_response.dart';

abstract class AiRepository {
  Future<AiMatchResponse> matchProblems(
    AiMatchRequest request, {
    String? token,
  });
}
