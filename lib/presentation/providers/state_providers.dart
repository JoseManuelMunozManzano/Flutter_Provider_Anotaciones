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
// Cambiando de @riverpod a @Riverpod() puedo añadir opciones, en este caso keepAlive: true
// para mantener el valor del estado cuando ya no uso la pantalla.
@Riverpod(keepAlive: true)
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

// Provider para gestionar el dark mode (botón de la luna)
// Usamos el snippet riverpodclass y nos movemos con la tecla Tab.
@riverpod
class DarkMode extends _$DarkMode {

  @override
  bool build() => false;
 
  void toggleDarkMode() {
    state = !state;
  }
}

// Provider para gestionar el botón de nombre aleatorio
// Usamos el snippet riverpodclass y nos movemos con la tecla Tab.
@Riverpod(keepAlive: true)
class Username extends _$Username {

  @override
  String build() {
    return 'Adriana Guarín';
  }

  void changeName(String name) {
    state = name;
  }
}
