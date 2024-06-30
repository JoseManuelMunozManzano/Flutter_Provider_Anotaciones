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
// De nuevo, para evitar que se tenga que hacer la llamada a la API, usamos @Riverpod con el keepAlive.
// Además mantiene en cache todos los demás pokemons por los que hemos pasado.
@Riverpod(keepAlive: true)
Future<String> pokemonName(PokemonNameRef ref) async {

  // IMPORTANTE: No podemos tener un provider que tiene un autoDispose() pero nuestro Future
  // depende de este valor de otro provider. Un provider puede "romper" el otro.
  // Para solucionar esto, en el otro provider indicamos el keepAlive a true.
  final pokemonId = ref.watch(pokemonIdProvider);

  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);

  // Este método nos permite ejecutar algún tipo de código cuando ya no se va a utilizar.
  // Usando keepAlive en true no se va a destruir y no se va a llegar a ejecutar nunca.
  //
  // PERO, usando en nuestro screen ref.invalidate() SI que entramos aquí, ya que estamos
  // invalidando nuestro provider.
  ref.onDispose(() {
    print('Estamos a punto de eliminar este provider');
  });

  return pokemonName;
}

// Provider con estado para ir incrementando el num. de Pokemon y hacemos dependiente el Future.
// En la siguiente clase vamos a ver como poder mandar argumentos al Future Provider y así evitar este paso.
// Usamos el snippet riverpodclass porque vamos a mantener un estado.
// Tenemos que indicar el keepAlive a true porque el Future Provider tiene un onDispose() y puede romper este
// al destruirse.
@Riverpod(keepAlive: true)
class PokemonId extends _$PokemonId {

  @override
  int build() => 1;

  void nextPokemon() {
    state++;
  }

  // Como se mantienen en caché todos los demás pokemons por los que hemos pasado, se puede hacer esto.
  // PERO NO FUNCIONA porque al hacer arriba el watch de pokemonIdProvider, al cambiar el state, se vuelve
  // a disparar todo el proceso de la petición.
  void previousPokemon() {

    if (state > 1) {
      state--;
    }
  }
}


//! Anteriormente llamados Family
// Usamos el snippet riverpod.
// Si necesitamos recibir el argumento desde el mundo exterior, solo tenemos que indicarlo
// en los argumentos de la función
// No olvidar indicar el keepAlive a true para que no se destruyan los valores anteriores
// y que no vuelve a hacer la petición.
// Recordar que todo esto de recibir el argumento y lo del keepAlive es para poder usar la caché del provider
// y no tener que volver a hacer peticiones de ids que ya tenemos en la caché.
@Riverpod(keepAlive: true)
Future<String> pokemon(PokemonRef ref, int pokemonId) async {

  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);

  return pokemonName;
}
