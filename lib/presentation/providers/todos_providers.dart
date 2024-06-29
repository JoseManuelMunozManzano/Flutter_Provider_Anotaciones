import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:uuid/uuid.dart';
import 'package:riverpod_app/domain/domain.dart';

// No olvidar ejecutar el build runner: dart run build_runner watch
// para que el código se autogenere.

// Esta vez el part lo hemos creado primero.
part 'todos_providers.g.dart';

const uuid = Uuid();

enum FilterType {all, completed, pending}

// Usamos el snipped riverpodclass porque necesito cambiar el estado.
@Riverpod(keepAlive: true)
class TodoCurrentFilter extends _$TodoCurrentFilter {
  
  @override
  FilterType build() => FilterType.all;

  void setCurrentFilter(FilterType newFilter) {
    state = newFilter;
  }
}

// Usamos el snipped riverpodclass porque necesito cambiar el estado.
@Riverpod(keepAlive: true)
class Todos extends _$Todos {

  // Nuestro estado inicial con data hardcodeada.
  @override
  List<Todo> build() => [
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
  ];

  // Toggle de completado
  void toggleTodo(String id) {

    // El map regresa un Iterable, pero nosotros necesitamos una lista, de ahí que acabe en .toList()
    state = state.map((todo) {
      if (todo.id == id) {
        // La única manera de cambiar una propiedad es crear una nueva instancia porque todas
        // las propiedades de la clase TODO son final. Usamos el patrón con copyWith()
        // Es decir, esto no es posible: todo.completedAt = DateTime.now()
        todo = todo.copyWith(
          completedAt: todo.done ? null : DateTime.now()
        );
      }

      return todo;
    }).toList();
  }

  // Añadido de una nueva persona
  void createTodo(String description) {
    state = [
      ...state,
      Todo(id: uuid.v4(), description: description, completedAt: null),
    ];
  }
}
