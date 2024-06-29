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

## Provider con cambios de estado

Vamos a trabajar con la tercera opción de la app, que es `State Provider`.

En este caso necesitamos un provider que pueda cambiar su estado. Sería un StateNotifierProvider.

En la carpeta `presentation/providers` creamos el provider `state_providers.dart`.

Modificamos `presentation/screens/03_state_provider/state_provider_screen.dart` para usar nuestro nuevo provider.

Una vez hecho todo, vemos que si salimos de esa tercera opción y volvemos a entrar, el nuevo valor se perdió (se destruyó el estado). Veremos más adelante por qué ocurre esto.

Vamos a hacer funcionar también tanto el botón de la luna (dark mode) como el del Nombre aleatorio.

Para el dark mode también modificamos `main.dart`, para que ese cambio de tema sea global a toda la app.

La idea que persigue Riverpod con sus providers es que tengamos providers muy pequeños, especializados en una tarea. Si ocupamos una combinación de los mismos, los podemos enlazar con providers de solo lectura y otras cosas que veremos más adelante.

## KeepAlive - Riverpod annotations

Recuerdo que en la pantalla de la app `State Provider`, si entro y aumento el contador, salgo de esa ruta y vuelvo a entrar, pierdo el valor de dicho contador. Igual para el nombre aleatorio.

Estos valores deberían de mantenerse.

Vemos que el tema oscuro se mantiene si salimos de dicha ruta, y esto es porque el main, que es donde tenemos el tema, se usa siempre y nunca se va a destruir. Sin embargo, nuestro `state_provider_screen.dart` se destruye tan pronto salimos al menú principal porque ya no es necesario.

Para mantener un provider vivo (y puede que lo queramos y puede que no) hacemos uso de `keepAlive: true` cuando hacemos uso de la anotación `@Riverpod`, con R mayúscula en vez de minúscula. Modificamos para ello `state_providers.dart`.

## TODOs - State Providers

Ahora nos centramos en la pantalla de la app `State Provider + Provider`.

De nuevo, una de las recomendaciones al trabajar con Riverpod es pensar en pequeños providers en lugar de un provider gigante.

Por tanto, vamos a tener tres providers, uno para saber cuál es el filtro seleccionado, otro para tener nuestra lista de invitados, y, cuando queramos aplicar el filtro, podemos crearnos un provider de solo lectura que lea este filtro, lea los todos y me regrese la cantidad de elementos acorde.

En `presentation/providers` vamos a crear un nuevo archivo de provider `todos_providers.dart`.

Este provider lo vamos a usar en la screen `presentation/screens/04_todo/todo_screen.dart`

## Testing

Ejecutar el build runner: `dart run build_runner watch`
