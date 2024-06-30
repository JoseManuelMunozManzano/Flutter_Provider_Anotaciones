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
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.refresh ),
        onPressed: () {  },
      ),
    );
  }
}
