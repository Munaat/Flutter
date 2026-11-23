import 'package:flutter/material.dart';

// Модель одной характеристики видеокарты (пункт основного экрана).
class GpuSpec {
  final IconData icon;
  final String title;
  final String subtitle;
  final String image; // картинка на экране детализации
  final String description; // подробное описание на экране детализации

  const GpuSpec({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.description,
  });
}
