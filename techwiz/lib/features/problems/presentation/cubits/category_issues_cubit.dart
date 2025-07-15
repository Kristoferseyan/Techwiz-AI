import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_issues_by_category_usecase.dart';
import 'category_issues_state.dart';

class CategoryIssuesCubit extends Cubit<CategoryIssuesState> {
  final GetIssuesByCategoryUseCase getIssuesByCategoryUseCase;

  CategoryIssuesCubit({required this.getIssuesByCategoryUseCase})
    : super(CategoryIssuesInitial());

  Future<void> loadIssuesByCategory(String category, {String? token}) async {
    emit(CategoryIssuesLoading());

    try {
      final issues = await getIssuesByCategoryUseCase(category, token: token);
      emit(CategoryIssuesLoaded(issues: issues, category: category));
    } catch (e) {
      emit(CategoryIssuesError('Failed to load issues: ${e.toString()}'));
    }
  }
}
