import '../../domain/entities/issue.dart';

abstract class CategoryIssuesState {}

class CategoryIssuesInitial extends CategoryIssuesState {}

class CategoryIssuesLoading extends CategoryIssuesState {}

class CategoryIssuesLoaded extends CategoryIssuesState {
  final List<Issue> issues;
  final String category;

  CategoryIssuesLoaded({required this.issues, required this.category});
}

class CategoryIssuesError extends CategoryIssuesState {
  final String message;

  CategoryIssuesError(this.message);
}
