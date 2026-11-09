import 'package:flutter/material.dart';

import '../routes.dart';

/// Нижняя панель навигации: «Главная» и «Профиль».
/// Используется на основном экране, экране детализации и в профиле.
class AppNavigationBar extends StatelessWidget {
  /// 0 — основной экран, 1 — профиль.
  final int currentIndex;

  const AppNavigationBar({super.key, required this.currentIndex});

  void _onDestinationSelected(BuildContext context, int index) {
    final route = index == 0 ? Routes.home : Routes.profile;
    // Уже открыт этот раздел — ничего не делаем.
    if (ModalRoute.of(context)?.settings.name == route) return;
    // Разделы панели — корневые экраны: открываем выбранный и очищаем стек.
    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: const Color(0xFFDDF5B5),
      indicatorColor: Colors.lightGreen.shade300,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: 64,
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Главная',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}
