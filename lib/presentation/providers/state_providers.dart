import 'package:riverpod_annotation/riverpod_annotation.dart';

// No olvidar ejecutar el build runner: dart run build_runner watch
// para que el código se autogenere.

// Esto lo hacemos lo último.
// Recordar que se indica el mismo nombre del archivo, pero antes de la extensión se indica un .g
// Y ese archivo .g se autogenera.
part 'state_providers.g.dart';

// Creamos el provider para manejar el contador.
// Usamos el snippet riverpodclass y nos movemos con la tecla Tab.
// _$Counter es código autogenerado por la parte de Riverpod.
@riverpod
class Counter extends _$Counter {

  // Con @override sobreescribimos nuestro estado inicial.
  @override
  int build() => 5;

  // Para incrementar el contador en 1 cuando se pulsa el botón.
  // Este método cambia el estado de este provider.
  void increaseByOne() {
    state++;
  }
}
