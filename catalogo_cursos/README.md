# Catálogo de cursos ESEIT

Taller práctico 1 · Desarrollo de aplicaciones móviles multiplataforma (Flutter + Dart).

La app muestra un indicador de carga mientras simula una consulta remota de 2 segundos
(`Future` + `async`/`await`) y luego presenta 6 cursos en tarjetas con nombre, docente,
duración, nivel, modalidad y cupos. Deslizar hacia abajo vuelve a ejecutar la carga.

## Estructura

| Archivo | Responsabilidad |
| --- | --- |
| `lib/main.dart` | Punto de entrada y `MaterialApp` (tema, título). |
| `lib/screens/home_screen.dart` | Pantalla principal; `FutureBuilder` controla carga, error y lista. |
| `lib/data/course_data.dart` | Colección tipada `List<Map<String, dynamic>>` y `obtenerCursos()` asíncrona. |
| `test/widget_test.dart` | Verifica tipos de datos y el flujo carga → lista. |

## Decisiones técnicas

- **`List<Map<String, dynamic>>`**: cada curso tiene valores de tipos distintos, así que el
  mapa usa `dynamic` como valor; pero cada dato conserva su tipo real: `duracion` y `cupos`
  son `int`, `virtual` es `bool`, el resto `String`. La lista es `const` (inmutable).
- **`Future<List<Map<String, dynamic>>> obtenerCursos() async`**: `await Future.delayed(...)`
  pausa la función sin bloquear la interfaz, simulando la latencia de una API.
- **`FutureBuilder`**: el `Future` se crea una sola vez en `initState` para que las
  reconstrucciones de la pantalla no repitan la consulta. Mientras
  `connectionState != done` se muestra `CircularProgressIndicator`; al terminar,
  `ListView.builder` recorre la lista y crea una `_TarjetaCurso` por curso.

## Ejecutar

```bash
flutter pub get
flutter run            # emulador / dispositivo
flutter run -d chrome  # navegador
flutter test
```

## Evidencias para la entrega

1. Captura durante la carga (indicador + "Consultando cursos disponibles...").
2. Captura de la lista ya cargada.
3. Captura de `lib/data/course_data.dart` mostrando `const List<Map<String, dynamic>> cursos`.
4. Captura de `obtenerCursos()` con `Future`, `async` y `await`.
5. Enlace a este repositorio.

## Guion sugerido para el video (4–7 min)

1. Presentación y objetivo de la app.
2. Ejecutar la app desde cero: se ve el indicador de carga y luego el catálogo.
3. `course_data.dart`: por qué `List<Map<String, dynamic>>` y por qué `int`/`bool` en vez de texto.
4. `obtenerCursos()`: qué hacen `Future`, `async` y `await Future.delayed`.
5. `home_screen.dart`: `FutureBuilder` (3 estados) y `ListView.builder` recorriendo los cursos.
6. Dificultad encontrada y cómo se resolvió (ej.: crear el `Future` en `initState` para no
   relanzar la carga en cada `build`).
7. Cierre mostrando la estructura del proyecto / el repositorio.
