import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
// import 'package:go_router/go_router.dart';

class RouterScreen extends ConsumerWidget {
  const RouterScreen({super.key});

  // El botón de vuelta atrás lo codificamos usando el provider de Riverpod en vez
  // de usar directamente el objeto de nuestro contexto (context.pop()).

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider + Go Router'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.arrow_back_ios_new_rounded ),
        onPressed: () {
          // Usando el contexto
          // context.pop();

          // Como estamos dentro de un método no hacemos ref.watch(), porque
          // no se puede redibujar dicho método. En un método, como el ciclo de vida initState() o
          // destroy(), se usa ref.read()
          ref.read(appRouterProvider).pop();
        },
      ),
    );
  }
}
