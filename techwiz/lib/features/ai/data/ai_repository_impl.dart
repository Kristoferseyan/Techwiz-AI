import '../domain/entities/ai_match_request.dart';
import '../domain/entities/ai_match_response.dart';
import '../domain/repositories/ai_repository.dart';
import 'ai_api_service.dart';

class AiRepositoryImpl implements AiRepository {
  final AiApiService apiService;

  AiRepositoryImpl(this.apiService);

  @override
  Future<AiMatchResponse> matchProblems(
    AiMatchRequest request, {
    String? token,
  }) async {
    return await apiService.matchProblems(request, token: token);
  }
}
