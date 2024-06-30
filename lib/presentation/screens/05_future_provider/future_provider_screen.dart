import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/future_providers.dart';


class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Comoo pokemonNameProvider es un Future, en pokemonName no tenemos
    // literalmente el valor, sino un AsyncValue, que puede tener tres valores:
    // Cuando se completa (data)
    // Cuando está cargando (loading)
    // Cuando sucede un error (error)
    // Cuando uno de estos tres posibles valores sucede, podemos reaccionar.
    final pokemonName = ref.watch(pokemonNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: Center(
        child: pokemonName.when(
          data: (data) => Text(data),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('$error'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            // Los FloatingActionButtons en los Scaffolds comparten un heroTag que es usado
            // para hacer una transición entre una pantalla y otra.
            // Si no se indica, como abajo hay otro FloatingActionButton, evita que se pueda
            // entrar a este screen (y a los otros screens tampoco pude entrar)
            heroTag: 'btn-1',
            child: const Icon(Icons.refresh),
            onPressed: () {
              // ref.invalidate(pokemonNameProvider);
              ref.read(pokemonIdProvider.notifier).nextPokemon();
            },
          ),

          const SizedBox(height: 10,),

          FloatingActionButton(
            // Igual, indicamos nuestro heroTag
            heroTag: 'btn-2',
            child: const Icon(Icons.minimize_outlined),
            onPressed: () {
              // ref.invalidate(pokemonNameProvider);
              ref.read(pokemonIdProvider.notifier).previousPokemon();
            },
          ),
        ],
      )
    );
  }
}
