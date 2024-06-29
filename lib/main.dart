import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/presentation/providers/state_providers.dart';

// Para que nosotros podamos usar nuestros providers de manera global en nuestra app
// tenemos que configurar ProviderScope.
void main() => runApp(
  const ProviderScope(child: MyApp())
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch(appRouterProvider);
    final isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp.router(
      title: 'Riverpod Providers',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme( isDarkmode: isDarkMode ).getTheme(),
    );
  }
}
