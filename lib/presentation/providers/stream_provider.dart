import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/config.dart';

// No olvidar ejecutar el build runner: dart run build_runner watch
// para que el código se autogenere.

part 'stream_provider.g.dart';

// Usamos el snippet riverpodKeepAlive para que ya tenga por defecto el keepAlive en true
@Riverpod(keepAlive: true)
Stream<List<String>> usersInChat(UsersInChatRef ref) async* {

  final names = <String>[];
  // Comentado para que nuestro stream no regrese un valor vacío muy rápido al inicio.
  // Así da tiempo a ver el progress indicator.
  // yield names;

  // Nos suscribimos al stream
  await for (final name in RandomGenerator.randomNameStream()) {
    names.add(name);
    yield names;
  }
}
