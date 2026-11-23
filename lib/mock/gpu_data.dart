import 'package:flutter/material.dart';

import '../models/gpu_spec.dart';

// Список изображений для горизонтальной галереи.
const List<String> kGpuImages = [
  'assets/images/video-card.png',
  'assets/images/processor.png',
  'assets/images/chip.png',
  'assets/images/motherboard.png',
  'assets/images/ram.png',
];

// Пункты основного экрана.
const List<GpuSpec> kGpuSpecs = [
  GpuSpec(
    icon: Icons.memory,
    title: 'Ядра CUDA: 16384',
    subtitle: 'Отвечают за расчёт графики и работу с нейросетями',
    image: 'assets/images/processor.png',
    description: 'CUDA-ядра — универсальные вычислительные блоки графического '
        'процессора. В RTX 4090 их 16384, они объединены в 128 потоковых '
        'мультипроцессоров (SM). Ядра выполняют шейдерные программы при '
        'отрисовке графики и параллельные вычисления в задачах машинного '
        'обучения.',
  ),
  GpuSpec(
    icon: Icons.sd_storage,
    title: 'Видеопамять: 24 ГБ GDDR6X',
    subtitle: 'Объём и тип видеопамяти',
    image: 'assets/images/ram.png',
    description: '24 ГБ памяти GDDR6X на 384-битной шине с пропускной '
        'способностью около 1 ТБ/с. Большой объём позволяет работать с '
        'текстурами высокого разрешения в 4K и загружать крупные '
        'нейросетевые модели.',
  ),
  GpuSpec(
    icon: Icons.precision_manufacturing,
    title: 'Техпроцесс: 4 нм (TSMC)',
    subtitle: 'Технология производства чипа',
    image: 'assets/images/chip.png',
    description: 'Графический процессор AD102 выпускается по техпроцессу '
        'TSMC 4N и содержит около 76,3 млрд транзисторов. Более тонкий '
        'техпроцесс позволяет разместить больше вычислительных блоков при '
        'меньшем энергопотреблении.',
  ),
  GpuSpec(
    icon: Icons.bolt,
    title: 'TDP: 450 Вт',
    subtitle: 'Максимальное тепловыделение',
    image: 'assets/images/video-card.png',
    description: 'Типичная потребляемая мощность видеокарты — 450 Вт. Для неё '
        'рекомендуется блок питания мощностью от 850 Вт, питание подаётся '
        'через 16-контактный разъём 12VHPWR.',
  ),
  GpuSpec(
    icon: Icons.speed,
    title: 'Частота: 2520 МГц (Boost)',
    subtitle: 'Максимальная частота ядра в режиме разгона',
    image: 'assets/images/motherboard.png',
    description: 'Базовая частота графического процессора — 2235 МГц, в режиме '
        'Boost — до 2520 МГц. Частота автоматически повышается, пока '
        'температура и энергопотребление остаются в допустимых пределах.',
  ),
];
