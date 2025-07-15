import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_paginated_issues_usecase.dart';
import 'paginated_issues_state.dart';

class PaginatedIssuesCubit extends Cubit<PaginatedIssuesState> {
  final GetPaginatedIssuesUseCase getPaginatedIssuesUseCase;

  PaginatedIssuesCubit({required this.getPaginatedIssuesUseCase})
    : super(PaginatedIssuesInitial());

  Future<void> loadPaginatedIssues({
    String? token,
    int page = 0,
    int size = 10,
  }) async {
    emit(PaginatedIssuesLoading());

    try {
      final paginatedIssues = await getPaginatedIssuesUseCase(
        token: token,
        page: page,
        size: size,
      );

      emit(PaginatedIssuesLoaded(paginatedIssues: paginatedIssues));
    } catch (e) {
      emit(
        PaginatedIssuesError(
          'Failed to load paginated issues: ${e.toString()}',
        ),
      );
    }
  }

  void reset() {
    emit(PaginatedIssuesInitial());
  }
}
