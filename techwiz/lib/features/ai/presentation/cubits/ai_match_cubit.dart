import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ai_match_request.dart';
import '../../domain/usecases/match_problems_usecase.dart';
import 'ai_match_state.dart';

class AiMatchCubit extends Cubit<AiMatchState> {
  final MatchProblemsUseCase matchProblemsUseCase;

  AiMatchCubit(this.matchProblemsUseCase) : super(AiMatchInitial());

  Future<void> matchProblems(
    String deviceType,
    String category,
    String description, {
    String? token,
  }) async {
    emit(AiMatchLoading());

    try {
      final request = AiMatchRequest(
        deviceType: deviceType,
        category: category,
        description: description,
      );

      final response = await matchProblemsUseCase(request, token: token);
      emit(AiMatchLoaded(response));
    } catch (e) {
      emit(AiMatchError(e.toString()));
    }
  }

  void reset() {
    emit(AiMatchInitial());
  }
}
