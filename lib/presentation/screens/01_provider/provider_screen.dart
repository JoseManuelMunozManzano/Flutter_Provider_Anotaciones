import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/hello_world_provider.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Obteniendo el valor de nuestro provider de solo lectura.
    // El nombre helloWorldProvider sale del código autogenerado en el fichero hello_world_provider.g.dart
    final helloWorld = ref.watch(helloWorldProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(
        child: Text(helloWorld),
      ),
    );
  }
}
