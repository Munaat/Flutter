part of 'specs_bloc.dart';

@immutable
sealed class SpecsState {
  const SpecsState();
}

// Ничего не загружено
final class SpecsInitial extends SpecsState {
  const SpecsInitial();
}

// Идёт загрузка
final class SpecsLoading extends SpecsState {
  const SpecsLoading();
}

// Успешная загрузка: получен список характеристик
final class SpecsLoaded extends SpecsState {
  final List<GpuSpec> specs;
  const SpecsLoaded(this.specs);
}

// Ошибка при загрузке
final class SpecsError extends SpecsState {
  final String message;
  const SpecsError(this.message);
}
