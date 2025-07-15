import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quick_action.dart';
import '../../domain/entities/guide.dart';
import '../../domain/usecases/get_quick_actions_usecase.dart';
import '../../domain/usecases/get_recent_guides_usecase.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetQuickActionsUseCase getQuickActionsUseCase;
  final GetRecentGuidesUseCase getRecentGuidesUseCase;

  DashboardCubit(
    DashboardState initialState, {
    required this.getQuickActionsUseCase,
    required this.getRecentGuidesUseCase,
  }) : super(initialState);

  Future<void> loadDashboard({String? token}) async {
    emit(DashboardLoading());

    try {
      final results = await Future.wait([
        getQuickActionsUseCase(token: token),
        getRecentGuidesUseCase(token: token),
      ]);

      emit(
        DashboardLoaded(
          quickActions: results[0] as List<QuickAction>,
          recentGuides: results[1] as List<Guide>,
        ),
      );
    } catch (e) {
      emit(DashboardError('Failed to load dashboard: ${e.toString()}'));
    }
  }
}
