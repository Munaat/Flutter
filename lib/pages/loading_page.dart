import 'package:flutter/material.dart';

import '../routes.dart';
import 'login_page.dart';

// Локальный main() для автономного запуска экрана (ПКМ → Run 'loading_page.dart').
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const LoadingPage(),
    routes: {Routes.login: (_) => const LoginPage()},
  ));
}

/// Экран заставки: иконка и название приложения.
/// Через 4 секунды автоматически заменяется экраном авторизации.
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Имитация инициализации приложения (загрузка настроек, данных).
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return; // экран могли закрыть до истечения таймера
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Иконка приложения в круглой рамке.
            Container(
              width: 140,
              height: 140,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Image.asset('assets/images/video-card.png'),
            ),
            const SizedBox(height: 32),
            const Text(
              'ВИДЕОКАРТЫ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.lightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
