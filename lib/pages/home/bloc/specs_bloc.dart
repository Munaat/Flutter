import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../mock/gpu_data.dart';
import '../../../models/gpu_spec.dart';

part 'specs_event.dart';
part 'specs_state.dart';

// Наследование от класса Bloc
class SpecsBloc extends Bloc<SpecsEvent, SpecsState> {
  // Начальное состояние при создании блока — ничего не загружено
  SpecsBloc() : super(const SpecsInitial()) {
    // Регистрируется обработчик события LoadSpecsEvent
    on<LoadSpecsEvent>(_onLoadSpecs);
  }

  Future<void> _onLoadSpecs(
    LoadSpecsEvent event,
    Emitter<SpecsState> emit,
  ) async {
    // Меняем состояние на индикатор загрузки
    emit(const SpecsLoading());
    try {
      // Имитация задержки загрузки (данных из внешнего источника нет)
      await Future.delayed(const Duration(milliseconds: 500));
      // Новое состояние со списком характеристик
      emit(SpecsLoaded(kGpuSpecs));
    } catch (e) {
      emit(const SpecsError('Не удалось загрузить данные'));
    }
  }
}
