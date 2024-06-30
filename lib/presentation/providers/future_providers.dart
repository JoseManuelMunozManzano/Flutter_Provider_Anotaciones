// No olvidar ejecutar el build runner: dart run build_runner watch
// para que el código se autogenere.

// Esta vez el part lo hemos creado primero.
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/config.dart';

part 'future_providers.g.dart';

// Usamos el snippet riverpodfuture porque es un Future Provider.
// Aunque también podemos usar el snippet riverpod e indicar que es un Future<String>.
// Por defecto, todos los providers de Riverpod tienen especificado el .autoDispose, es decir,
// cuando ya no se usan, se va a borrar para liberar la memoria, por lo que cuando salimos
// del screen y volvemos a entrar se vuelve a hacer la petición asíncrona.
// De nuevo, para evitar que se tenga que hacer la llamada a la API, usamos @Riverpod con el keepAlive
@Riverpod(keepAlive: true)
Future<String> pokemonName(PokemonNameRef ref) async {

  final pokemonName = await PokemonInformation.getPokemonName(1);

  // Este método nos permite ejecutar algún tipo de código cuando ya no se va a utilizar.
  // Usando keepAlive en true no se va a destruir y no se va a llegar a ejecutar nunca.
  ref.onDispose(() {
    print('Estamos a punto de eliminar este provider');
  });

  return pokemonName;
}
