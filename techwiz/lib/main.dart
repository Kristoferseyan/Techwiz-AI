import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:techwiz/features/auth/data/auth_api_service.dart';
import 'package:techwiz/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:techwiz/features/auth/domain/usecases/login_user.dart';
import 'package:techwiz/features/auth/domain/usecases/register_user.dart';
import 'package:techwiz/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:techwiz/features/auth/presentation/cubits/auth_state.dart';
import 'package:techwiz/features/auth/presentation/screens/login_page.dart';
import 'package:techwiz/features/auth/presentation/screens/register_page.dart';
import 'package:techwiz/features/dashboard/data/dashboard_api_service.dart';
import 'package:techwiz/features/dashboard/data/dashboard_repository_impl.dart';
import 'package:techwiz/features/dashboard/domain/usecases/get_quick_actions.dart';
import 'package:techwiz/features/dashboard/domain/usecases/get_common_issues.dart';
import 'package:techwiz/features/dashboard/domain/usecases/get_recent_guides.dart';
import 'package:techwiz/features/dashboard/domain/usecases/get_categories.dart';
import 'package:techwiz/features/dashboard/domain/usecases/search_issues.dart';
import 'package:techwiz/features/dashboard/domain/usecases/get_paginated_issues.dart';
import 'package:techwiz/features/dashboard/presentation/cubits/paginated_issues_cubit.dart';
import 'package:techwiz/features/dashboard/presentation/cubits/paginated_issues_state.dart';
import 'package:techwiz/features/dashboard/domain/usecases/get_issues_by_category.dart';
import 'package:techwiz/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:techwiz/features/dashboard/presentation/cubits/dashboard_state.dart';
import 'package:techwiz/features/dashboard/presentation/screens/dashboard_page.dart';
import 'package:techwiz/utils/colors.dart';
import 'package:techwiz/utils/theme_manager.dart';

Future<void> main() async {
  await dotenv.load();
  final httpClient = http.Client();

  final authApiService = AuthApiService(httpClient);
  final authRepository = AuthRepositoryImpl(authApiService);

  final dashboardApiService = DashboardApiService(httpClient);
  final dashboardRepository = DashboardRepositoryImpl(dashboardApiService);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(
            AuthInitial(),
            loginUser: LoginUser(authRepository),
            registerUser: RegisterUser(authRepository),
          ),
        ),
        BlocProvider(
          create: (_) => DashboardCubit(
            DashboardInitial(),
            getQuickActions: GetQuickActions(dashboardRepository),
            getCommonIssues: GetCommonIssues(dashboardRepository),
            getRecentGuides: GetRecentGuides(dashboardRepository),
            getCategories: GetCategories(dashboardRepository),
            searchIssues: SearchIssues(dashboardRepository),
            getIssuesByCategory: GetIssuesByCategory(dashboardRepository),
          ),
        ),
        BlocProvider(
          create: (_) => PaginatedIssuesCubit(
            getPaginatedIssues: GetPaginatedIssues(dashboardRepository),
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      builder: (context, _) {
        final themeManager = Provider.of<ThemeManager>(context);
        return MaterialApp(
          title: 'TechWiz',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: AppColors.lightColorScheme,
            useMaterial3: true,
            fontFamily: 'System',
          ),
          darkTheme: ThemeData(
            colorScheme: AppColors.darkColorScheme,
            useMaterial3: true,
            fontFamily: 'System',
          ),
          themeMode: themeManager.themeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
            '/home': (context) => const DashboardPage(),
          },
        );
      },
    );
  }
}
