import '../../domain/entities/paginated_response.dart';
import '../../domain/entities/issue.dart';

abstract class PaginatedIssuesState {}

class PaginatedIssuesInitial extends PaginatedIssuesState {}

class PaginatedIssuesLoading extends PaginatedIssuesState {}

class PaginatedIssuesLoaded extends PaginatedIssuesState {
  final PaginatedResponse<Issue> paginatedIssues;

  PaginatedIssuesLoaded({required this.paginatedIssues});
}

class PaginatedIssuesError extends PaginatedIssuesState {
  final String message;

  PaginatedIssuesError(this.message);
}
