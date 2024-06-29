# riverpod_app

En este curso nos vamos a centrar en la parte de generación de código de Riverpod, y usando anotaciones.

Documentación: `https://riverpod.dev/docs/introduction/getting_started`

En esta página de documentación, marcar el check `Code generation`.

Para la instalación, tal y como puede verse en la documentación, hay que ejecutar:

```
flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add dev:riverpod_generator
flutter pub add dev:build_runner
flutter pub add dev:custom_lint
flutter pub add dev:riverpod_lint
```

Instalados estos paquetes, ya podemos ejecutar la generación de código con `dart run build_runner watch`. Este comando va a estar pendiente de las anotaciones que hagamos y, cuando encuentre un cambio, lo va a volver a generar.

Este comando siempre tiene que estar en ejecución.

## Provider de solo lectura

Vamos a crear nuestro primer provider, que es de solo lectura.

En la carpeta `presentation` creamos la carpeta `providers`, y dentro el provider `hello_world_provider.dart` y el archivo de barril `providers.dart`.

Nos vamos a `presentation/screens/01_provider/provider_screen.dart`. La idea es hacer que el texto venga de nuestro provider.

## Testing

Ejecutar el build runner: `dart run build_runner watch`
