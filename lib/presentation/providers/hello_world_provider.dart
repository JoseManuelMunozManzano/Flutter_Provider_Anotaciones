import 'package:riverpod_annotation/riverpod_annotation.dart';

// No olvidar ejecutar el build runner: dart run build_runner watch
// para que el código se autogenere.

// Para archivos autogenerados.
// Esto es muy típico en Dart y Flutter.
// Se indica el mismo nombre del archivo, pero añadiendo .g antes de la extensión.
// En el momento en que se pulsa Cmd+S y se graba, se autogenera el archivo hello_world_provider.g.dart
part 'hello_world_provider.g.dart';

// Provider de solo lectura que regresa un String.
// Este HelloWorldRef se forma con el mismo nombre de la función, pero con la primera letra capitalizada.
// El tipo no existe, pero se va a crear de manera automática al crear el part de arriba.
// Con el ref vamos a poder obtener la referencia a todos los otros providers de Riverpod que
// ya estén creados, o que no estén creados pero que en ese momento se van a crear.
@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hola Mundo';
}
