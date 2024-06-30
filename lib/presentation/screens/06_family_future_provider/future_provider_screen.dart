import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/future_providers.dart';

// Vamos a mantener un estado local (StatefulWidget) con el id del pokemon y vamos a hacer
// algo similar a lo que hicimos en 05_future_provider.
//
// Luego lo transformamos a un ConsumerStatefulWidget para usar el provider.

class FamilyFutureScreen extends ConsumerStatefulWidget {
  const FamilyFutureScreen({super.key});

  @override
  FamilyFutureScreenState createState() => FamilyFutureScreenState();
}

class FamilyFutureScreenState extends ConsumerState<FamilyFutureScreen> {

  int pokemonId = 3;

  // Indicar que ya no hace falta indicar el argumento WidgetRef ya que un ConsumerStatefulWidget
  // ya puede usar el ref de manera global en el state.
  @override
  Widget build(BuildContext context) {

    // Tenemos que pasarle el argumento que espera.
    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon id: $pokemonId'),
      ),
      body: Center(
        child: pokemonAsync.when(
          data: (data) => Text(data),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('$error'),
        )
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
              child: const Icon(Icons.add),
              onPressed: () {
                pokemonId++;
                setState(() {
                  
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              // Igual, indicamos nuestro heroTag
              heroTag: 'btn-2',
              child: const Icon(Icons.exposure_minus_1),
              onPressed: () {
                if (pokemonId <= 1) return;
                pokemonId--;
                setState(() {
                  
                });
              },
            ),
          ],
        )
    );
  }
}
