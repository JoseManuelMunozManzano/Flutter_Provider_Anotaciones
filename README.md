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

## TODOs - Listado de invitados

Seguimos en la pantalla de la app `State Provider + Provider` y en nuestro provider `todos_providers.dart`.

Nos vamos a crear otro provider para toda la lista de nuestros invitados y de nuevo lo consumimos en `presentation/screens/04_todo/todo_screen.dart`.

## TODOs - Toggle

Seguimos en la pantalla de la app `State Provider + Provider` y en nuestro provider `todos_providers.dart`.

Para hacer el toggle, necesitamos hacer otro método en nuestra clase Todos para recibir el id, y si está marcado como completado, le ponemos null. Si está a null le ponemos como completado a una fecha DateTime.now().

Lo consumimos en `presentation/screens/04_todo/todo_screen.dart`.

## TODOs - Aplicar el filtro seleccionado

Seguimos en la pantalla de la app `State Provider + Provider` y en nuestro provider `todos_providers.dart`.

Es momento de aplicar el filtro. Vamos a usar un provider de solo lectura.

Lo consumimos en `presentation/screens/04_todo/todo_screen.dart`.

## Future Provider

Vamos a trabajar en la pantalla de `Future Provider`.

La idea es que, cuando estemos dentro, hagamos una petición asíncrona y traigamos información. Para ello usaremos el fuente que tenemos en `config/helpers/pokemon_information.dart`, donde hemos puesto un delay de 2sg de manera intencionada.

En `presentation/providers` vamos a crear un nuevo archivo de provider `future_providers.dart`.

Lo consumimos en nuestro screen `presentation/screens/05_future_provider/future_provider_screen.dart`.

## Provider invalidar y dependencias

Seguimos en la pantalla de la app `Future Provider` y en nuestro provider `future_providers.dart`.

Lo consumimos en `presentation/screens/05_future_provider/future_provider_screen.dart`.

Vamos a hacer una prueba del uso en nuestro screen de `ref.invalidate()`, al pulsar el botón del screen, para llamar al `ref.onDispose()` en nuestro provider. Con esto destruimos el provider.

Lo otro que hacemos es comentar el `ref.invalidate()` que hemos creado como prueba, y usar el botón del screen para mostrar el siguiente pokemon.

También vemos que los pokemons anteriores se quedan guardados en caché del provider y creamos un nuevo botón para volver a acceder a ellos. El problema es que, tal y como lo hemos hecho, no va a funcionar, no lo tiene en su ProviderScope y tiene que volver a hacer la petición. El problema es que en nuestro FutureProvider no tenemos ninguna dependencia, sino que el id cambia y vuelve a lanzar todo el proceso de construcción de ese nuevo valor del Future.

En la siguiente clase vamos a abordar el problema para mantener los valores de los Futures para traer esta información del caché.

## Future Provider con argumentos

Vamos a trabajar en la pantalla de `Family Future Provider`.

Antes de usar anotaciones, el concepto family indicaba que podíamos mandarle un argumento a nuestro provider, y, acorde a ese argumento, podíamos determinar algo.

Lo bueno del family es que, si el argumento era el mismo valor y ya tenía una resolución de un Future, entonces devuelve ese mismo valor del Future, a menos de que lo hayamos invalidado.

Seguimos en nuestro archivo de providers `future_providers.dart`, donde nos creamos un nuevo provider `pokemon` que recibe como argumento un entero con el número de pokemon.

Lo consumimos en `presentation/screens/06_family_future_provider/future_provider_screen.dart` donde por primera vez usamos un `StatefulWidget`.

## Stream Provider

Vamos a trabajar en la pantalla de `Stream Provider`.

Un Stream Provider tiene la misma complejidad y características que un Future Provider y se diferencia en el uso de yield en vez de return, en el uso de async\* en vez de async y que maneja un stream en vez de un Future.

En `presentation/providers` vamos a crear un nuevo archivo de provider `stream_provider.dart`.

Lo consumimos en `presentation/screens/07_stream_provider/stream_provider_screen.dart`

Vemos que si estamos en este screen y no se han emitido todos los valores, salimos del screen, esperamos un poco y volvemos a entrar, veremos que sale la data que se ha estado emitiendo mientras estábamos fuera del screen. Esto ocurre porque el proceso que se está ejecutando no está amarrado al widget, sino al provider, y esto es muy útil.

Las siguientes pantallas NO tienen provider con anotaciones, por lo que NO se ven.

## Testing

Ejecutar el build runner: `dart run build_runner watch`
