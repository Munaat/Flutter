part of 'specs_bloc.dart';

@immutable
sealed class SpecsEvent {
  const SpecsEvent();
}

// Событие: загрузить список характеристик видеокарты
final class LoadSpecsEvent extends SpecsEvent {
  const LoadSpecsEvent();
}
