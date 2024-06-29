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

## AppRouter como Provider

Aunque el provider de lectura que hemos visto parece muy sencillo y no hace nada, vamos a ver este caso de uso real.

Corresponde al ejemplo de nuestra app `Provider + Go_Router`.

Tenemos nuestro archivo de go_router en `config/router/app_router.dart`. Imaginemos que dependemos de un provider que nos diga si la persona está autenticada o no. Si está autenticada va a mostrar las tres primeras rutas, pero si no lo está va a mostrar solo la última ruta. Es decir, basado en la autenticación vamos a construir las rutas de manera dinámica. El provider de solo lectura se va a estar enfocando en actualizarse si se dan ciertas condiciones, como que se actualice la autenticación.

Vamos a modificar nuestro `GoRouter` en un provider de solo lectura. Modificamos `config/router/app_router.dart`.

También tenemos que modificar nuestro archivo `main.dart`.

Vamos a usar esta nueva instancia de nuestro `appRouterProvider` en otra pantalla para ver como se consume dicha instancia. Modificamos `presentation/screens/02_provider_router/router_screen.dart`.

## Testing

Ejecutar el build runner: `dart run build_runner watch`
