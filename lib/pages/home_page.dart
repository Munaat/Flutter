import 'package:flutter/material.dart';

import 'profile_page.dart';

// Локальный main() для автономного запуска экрана (ПКМ → Run 'home_page.dart').
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GpuInfoPage(),
  ));
}

// Список изображений для горизонтального ListView.
const List<String> kGpuImages = [
  'assets/images/video-card.png',
  'assets/images/processor.png',
  'assets/images/chip.png',
  'assets/images/motherboard.png',
  'assets/images/ram.png',
];

// Модель одной характеристики видеокарты для вертикального ListView.
class GpuSpec {
  final IconData icon;
  final String title;
  final String subtitle;

  const GpuSpec({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

// Список характеристик, отображаемых карточками (Card) в вертикальном ListView.
const List<GpuSpec> kGpuSpecs = [
  GpuSpec(
    icon: Icons.memory,
    title: 'Ядра CUDA: 16384',
    subtitle: 'Отвечают за расчёт графики и работу с нейросетями',
  ),
  GpuSpec(
    icon: Icons.sd_storage,
    title: 'Видеопамять: 24 ГБ GDDR6X',
    subtitle: 'Объём и тип видеопамяти',
  ),
  GpuSpec(
    icon: Icons.precision_manufacturing,
    title: 'Техпроцесс: 4 нм (TSMC)',
    subtitle: 'Технология производства чипа',
  ),
  GpuSpec(
    icon: Icons.bolt,
    title: 'TDP: 450 Вт',
    subtitle: 'Максимальное тепловыделение',
  ),
  GpuSpec(
    icon: Icons.speed,
    title: 'Частота: 2520 МГц (Boost)',
    subtitle: 'Максимальная частота ядра в режиме разгона',
  ),
];

class GpuInfoPage extends StatelessWidget {
  // Данные пользователя, переданные с экрана входа/регистрации.
  final String name;
  final String email;

  const GpuInfoPage({
    super.key,
    this.name = 'Иванов Иван Иванович',
    this.email = 'test123@mail.ru',
  });

  // Показывает SnackBar с названием выбранного пункта характеристик.
  void _showSpecSnackBar(BuildContext context, GpuSpec spec) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(spec.title),
        persist: false, // возвращает автоматическое скрытие по duration
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ВИДЕОКАРТЫ',
          style: TextStyle(fontFamily: 'Orbitron', letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: [
          // Переход на экран профиля пользователя.
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Профиль',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProfilePage(name: name, email: email),
              ),
            ),
          ),
        ],
      ), // AppBar
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Название ПО
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'NVIDIA GeForce RTX 4090',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ), // Container: название ПО
                const SizedBox(height: 16),

                // Описание ПО
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Видеокарта (графический адаптер, GPU) — устройство, отвечающее '
                        'за формирование и вывод изображения на экран, а также за '
                        'ускорение вычислений, связанных с обработкой графики. '
                        'NVIDIA GeForce RTX 4090 — флагманская видеокарта на архитектуре '
                        'Ada Lovelace, предназначенная для игр в разрешении 4K и '
                        'профессиональных задач: рендеринга, работы с нейросетями и '
                        'трассировки лучей в реальном времени.',
                    style: TextStyle(fontSize: 16),
                  ),
                ), // Container: описание ПО
                const SizedBox(height: 12),

                const Text(
                  'Галерея (горизонтальный список)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ), // Padding: название, описание, заголовок галереи

          // Горизонтальный ListView с изображениями со скруглёнными углами.
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: kGpuImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 120,
                      color: Colors.grey.shade200,
                      child: Image.asset(
                        kGpuImages[index],
                        fit: BoxFit.contain,
                      ), // Image.asset
                    ),
                  ), // ClipRRect: скруглённые углы изображения
                );
              },
            ), // ListView.builder: горизонтальная галерея
          ), // SizedBox: ограничение высоты горизонтального ListView

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Характеристики (вертикальный список)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Вертикальный ListView из карточек с характеристиками.
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: kGpuSpecs.length,
              itemBuilder: (context, index) {
                final spec = kGpuSpecs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(spec.icon, color: Colors.deepPurple),
                    title: Text(spec.title),
                    subtitle: Text(spec.subtitle),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _showSpecSnackBar(context, spec),
                  ), // ListTile: иконка, заголовок, подзаголовок, стрелка
                ); // Card: карточка характеристики
              },
            ), // ListView.builder: вертикальный список характеристик
          ), // Expanded: список характеристик занимает оставшееся место

          const Divider(height: 1),

          // ФИО и номер группы
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.person, size: 32),
                ), // Container: иконка пользователя
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Ерашов Тимофей Дмитриевич\n'
                          'ИКБО-64-23\n'
                          '23И1816',
                    ),
                  ),
                ), // Container: ФИО, группа, номер студенческого билета
              ],
            ), // Row: ФИО номер группы
          ), // Padding: блок данных студента
        ],
      ), // Column
    ); // Scaffold
  }
}
