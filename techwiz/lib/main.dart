import 'dart:io';

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
import 'package:techwiz/screens/home.dart';
import 'package:techwiz/utils/colors.dart';
import 'package:techwiz/utils/theme_manager.dart';

Future<void> main() async {
  await dotenv.load();
  final httpClient = http.Client();
  final apiService = AuthApiService(httpClient);
  final authRepository = AuthRepositoryImpl(apiService);

  runApp(
    BlocProvider(
      create: (_) => AuthCubit(
        AuthInitial(),
        loginUser: LoginUser(authRepository),
        registerUser: RegisterUser(authRepository),
      ),
      child: MainApp(),
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
            '/home': (context) => const HomePage(),
          },
        );
      },
    );
  }
}
