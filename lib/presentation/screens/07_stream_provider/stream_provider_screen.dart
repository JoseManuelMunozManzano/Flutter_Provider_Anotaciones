import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/stream_provider.dart';


class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: const StreamView()
    );
  }
}

// Aquí mostramos todos los valores que está emitiendo nuestro stream.
class StreamView extends ConsumerWidget {
  const StreamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final usersInChatAsync = ref.watch(usersInChatProvider);

    // Un stream se puede tratar como un Future provider, con el .when y tratando la data, loading y error.
    // Esta opción es más bonita de ver.
    // Pero también se puede tratar de esta forma, con los argumentos isLoading y hasError. Si no se cumple ninguno
    // es que tenemos data (que sería usar hasValue, pero ya sabemos que tenemos data)
    if (usersInChatAsync.isLoading) {
      return const CircularProgressIndicator();
    }

    if (usersInChatAsync.hasError) {
      return Center(
        child: Text('$usersInChatAsync.error')
      );
    }

    // Ya sabemos que tenemos data en este punto porque ya evaluamos los casos anteriores.
    final users = usersInChatAsync.value!;

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {

        final user = users[index];

        return ListTile(
          title: Text(user),
        );
      },
    );
  }
}
