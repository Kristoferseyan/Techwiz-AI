import '../entities/ai_match_request.dart';
import '../entities/ai_match_response.dart';
import '../repositories/ai_repository.dart';

class MatchProblemsUseCase {
  final AiRepository repository;

  MatchProblemsUseCase(this.repository);

  Future<AiMatchResponse> call(AiMatchRequest request, {String? token}) async {
    return await repository.matchProblems(request, token: token);
  }
}
