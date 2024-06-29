import 'package:riverpod_annotation/riverpod_annotation.dart';

// No olvidar ejecutar el build runner: dart run build_runner watch
// para que el código se autogenere.

// Esta vez el part lo hemos creado primero.
part 'todos_providers.g.dart';

enum FilterType {all, completed, pending}

// Usamos el snipped riverpodclass porque necesito cambiar el estado.
@riverpod
class TodoCurrentFilter extends _$TodoCurrentFilter {
  
  @override
  FilterType build() => FilterType.all;

  void setCurrentFilter(FilterType newFilter) {
    state = newFilter;
  }
}
