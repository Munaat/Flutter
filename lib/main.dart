import 'package:flutter/material.dart';

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
      ), // ThemeData
      home: const GpuInfoPage(),
    ); // MaterialApp
  }
}

// Список изображений для циклической смены в области "картинки".
// Хранится вне State, так как сам список не меняется — меняется только
// индекс текущего показанного изображения.
const List<String> kGpuImages = [
  'assets/images/video-card.png',
  'assets/images/processor.png',
  'assets/images/chip.png',
  'assets/images/motherboard.png',
  'assets/images/ram.png',
];

class GpuInfoPage extends StatefulWidget {
  const GpuInfoPage({super.key});

  @override
  State<GpuInfoPage> createState() => _GpuInfoPageState();
}

class _GpuInfoPageState extends State<GpuInfoPage> {
  // State: индекс текущего изображения в списке kGpuImages.
  int _imageIndex = 0;

  // Переключает изображение на следующее по кругу (после последнего —
  // снова первое). Вызывается и по нажатию на кнопку, и по тапу на картинке.
  void _nextImage() {
    setState(() {
      _imageIndex = (_imageIndex + 1) % kGpuImages.length;
    });
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
      ), // AppBar
      body: SingleChildScrollView(
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
            const SizedBox(height: 16),

            // Картинка (с циклической сменой по тапу) + список характеристик
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _nextImage,
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        kGpuImages[_imageIndex],
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ), // Image.asset
                    ),
                  ), // GestureDetector: тап по картинке переключает её
                ), // Expanded: картинка
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1. Ядра CUDA: 16384'),
                        SizedBox(height: 6),
                        Text('2. Видеопамять: 24 ГБ GDDR6X'),
                        SizedBox(height: 6),
                        Text('3. Техпроцесс: 4 нм (TSMC)'),
                        SizedBox(height: 6),
                        Text('4. TDP: 450 Вт'),
                      ],
                    ),
                  ),
                ), // Expanded: список характеристик
              ],
            ), // Row: картинка + список
            const SizedBox(height: 12),

            // Кнопка для смены изображения (дублирует тап по картинке)
            Center(
              child: ElevatedButton(
                onPressed: _nextImage,
                child: const Text('Следующее изображение'),
              ),
            ), // Center: кнопка смены картинки
            const SizedBox(height: 16),

            const Divider(),
            const SizedBox(height: 16),

            // ФИО и номер группы
            Row(
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
          ],
        ), // Column
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
