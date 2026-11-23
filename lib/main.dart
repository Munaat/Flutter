import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/detail_page.dart';
import 'pages/home/bloc/specs_bloc.dart';
import 'pages/home/home_page.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/profile_page.dart';
import 'pages/register_page.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Видеокарты',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Императивная навигация (Navigator 1.0) по именованным маршрутам.
      initialRoute: Routes.loading,
      routes: {
        Routes.loading: (_) => const LoadingPage(),
        Routes.login: (_) => const LoginPage(),
        Routes.register: (_) => const RegisterPage(),
        // Новый SpecsBloc создаётся при открытии экрана, событие загрузки
        // сразу добавляется в поток каскадным оператором (..).
        Routes.home: (_) => BlocProvider(
              create: (_) => SpecsBloc()..add(const LoadSpecsEvent()),
              child: const HomePage(),
            ),
        Routes.detail: (_) => const DetailPage(),
        Routes.profile: (_) => const ProfilePage(),
      },
    );
  }
}
