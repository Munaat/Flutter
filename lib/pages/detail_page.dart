import 'package:flutter/material.dart';

import '../mock/gpu_data.dart';
import '../widgets/app_navigation_bar.dart';

// Локальный main() для автономного запуска экрана (ПКМ → Run 'detail_page.dart').
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DetailPage(index: 0),
  ));
}

/// Экран детализации пункта основного экрана.
/// Номер пункта приходит в аргументах маршрута: pushNamed(Routes.detail, arguments: index).
class DetailPage extends StatelessWidget {
  /// Номер пункта для автономного запуска; при переходе по маршруту не задаётся.
  final int? index;

  const DetailPage({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final int i = index ?? (args is int ? args : 0);
    final spec = kGpuSpecs[i];

    return Scaffold(
      backgroundColor: Colors.white,
      // Стрелку «назад» AppBar добавляет сам, так как экран открыт через push.
      appBar: AppBar(
        title: Text(spec.title.toUpperCase()),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Картинка пункта в скруглённой рамке.
            Center(
              child: Container(
                width: 220,
                height: 160,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(spec.image, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              spec.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              spec.description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 0),
    );
  }
}
