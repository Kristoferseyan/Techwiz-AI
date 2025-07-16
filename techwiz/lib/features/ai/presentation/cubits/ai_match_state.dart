import '../../domain/entities/ai_match_response.dart';

abstract class AiMatchState {}

class AiMatchInitial extends AiMatchState {}

class AiMatchLoading extends AiMatchState {}

class AiMatchLoaded extends AiMatchState {
  final AiMatchResponse response;

  AiMatchLoaded(this.response);
}

class AiMatchError extends AiMatchState {
  final String message;

  AiMatchError(this.message);
}
