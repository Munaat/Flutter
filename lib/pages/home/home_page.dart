import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../mock/gpu_data.dart';
import '../../models/gpu_spec.dart';
import '../../routes.dart';
import '../../widgets/app_navigation_bar.dart';
import 'bloc/specs_bloc.dart';

// Локальный main() для автономного запуска экрана (ПКМ → Run 'home_page.dart').
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (_) => SpecsBloc()..add(const LoadSpecsEvent()),
      child: const HomePage(),
    ),
  ));
}

/// Основной экран приложения. Состоянием экрана управляет SpecsBloc.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Десктоп и веб: на больших экранах увеличиваем отступы между блоками.
  static bool get _isDesktopOrWeb =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  void _openDetail(BuildContext context, int index) {
    Navigator.pushNamed(context, Routes.detail, arguments: index);
  }

  // Блок с рамкой для названия и описания ПО.
  Widget _framed(Widget child, {Alignment? alignment}) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: alignment,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double gap = _isDesktopOrWeb ? 32 : 16; // отступ между блоками

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ВИДЕОКАРТЫ',
          style: TextStyle(fontFamily: 'Orbitron', letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      // BlocBuilder перестраивает экран при каждом изменении состояния SpecsBloc.
      body: BlocBuilder<SpecsBloc, SpecsState>(
        builder: (context, state) {
          switch (state) {
            case SpecsInitial():
              return const Center(child: Text('Данные ещё не загружены'));
            case SpecsLoading():
              return const Center(
                child: CircularProgressIndicator(color: Colors.lightGreen),
              );
            case SpecsError(:final message):
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context
                          .read<SpecsBloc>()
                          .add(const LoadSpecsEvent()),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              );
            case SpecsLoaded(:final specs):
              if (specs.isEmpty) {
                return const Center(child: Text('Список пуст'));
              }

              // LayoutBuilder отдаёт ширину экрана: по ней выбираем раскладку.
              return LayoutBuilder(
                builder: (context, constraints) {
                  final bool wide = constraints.maxWidth > 600;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: gap / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Название ПО
                        _framed(
                          const Text(
                            'NVIDIA GeForce RTX 4090',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          alignment: Alignment.center,
                        ),
                        SizedBox(height: gap),

                        // Описание ПО
                        _framed(
                          const Text(
                            'Видеокарта (графический адаптер, GPU) — устройство, отвечающее '
                            'за формирование и вывод изображения на экран, а также за '
                            'ускорение вычислений, связанных с обработкой графики. '
                            'NVIDIA GeForce RTX 4090 — флагманская видеокарта на архитектуре '
                            'Ada Lovelace, предназначенная для игр в разрешении 4K и '
                            'профессиональных задач: рендеринга, работы с нейросетями и '
                            'трассировки лучей в реальном времени.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: gap),

                        const Text(
                          'Галерея (горизонтальный список)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        // Горизонтальный ListView с изображениями со скруглёнными углами.
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: kGpuImages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: 120,
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.grey.shade200,
                                    child: Image.asset(
                                      kGpuImages[index],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: gap),

                        const Text(
                          'Характеристики',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        // Ширина больше 600 — карточки в 2 столбца, иначе — в один.
                        wide
                            ? _buildSpecGrid(context, specs)
                            : _buildSpecList(context, specs),
                        SizedBox(height: gap),

                        const Divider(height: 1),
                        SizedBox(height: gap / 2),
                        const _StudentInfo(),
                      ],
                    ),
                  );
                },
              );
          }
        },
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 0),
    );
  }

  // Узкий экран: карточки одна под другой.
  Widget _buildSpecList(BuildContext context, List<GpuSpec> specs) {
    return Column(
      children: [
        for (int i = 0; i < specs.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _SpecCard(
              spec: specs[i],
              onTap: () => _openDetail(context, i),
            ),
          ),
      ],
    );
  }

  // Широкий экран: сетка из 2 столбцов.
  Widget _buildSpecGrid(BuildContext context, List<GpuSpec> specs) {
    return GridView.builder(
      shrinkWrap: true, // высота сетки — по содержимому
      physics: const NeverScrollableScrollPhysics(), // прокручивает весь экран
      itemCount: specs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 96,
      ),
      itemBuilder: (context, i) => _SpecCard(
        spec: specs[i],
        onTap: () => _openDetail(context, i),
      ),
    );
  }
}

/// Карточка пункта: иконка, заголовок, подзаголовок, стрелка.
class _SpecCard extends StatelessWidget {
  final GpuSpec spec;
  final VoidCallback onTap;

  const _SpecCard({required this.spec, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: ListTile(
          leading: Icon(spec.icon, color: Colors.deepPurple),
          title: Text(spec.title),
          subtitle: Text(
            spec.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}

/// Блок с ФИО, номером группы и студенческого билета.
class _StudentInfo extends StatelessWidget {
  const _StudentInfo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.person, size: 32),
        ),
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
        ),
      ],
    );
  }
}
