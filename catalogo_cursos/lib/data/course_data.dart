/// Datos locales del catálogo y simulación de una consulta remota.
library;

/// Tiempo que tarda la "consulta" simulada (entre 1 y 2 segundos).
const Duration tiempoDeCarga = Duration(seconds: 2);

/// Colección tipada con los cursos del catálogo.
///
/// Cada curso es un `Map<String, dynamic>` porque sus valores tienen tipos
/// distintos: textos (`String`), números enteros (`int`) y banderas (`bool`).
/// `const` la hace inmutable: nadie puede agregar, quitar ni cambiar cursos.
const List<Map<String, dynamic>> cursos = [
  {
    'nombre': 'Fundamentos de Dart',
    'docente': 'Ing. Laura Restrepo',
    'duracion': 16, // horas
    'nivel': 'Básico',
    'virtual': true,
    'cupos': 30,
  },
  {
    'nombre': 'Widgets y Layouts en Flutter',
    'docente': 'Ing. Andrés Cardona',
    'duracion': 24,
    'nivel': 'Básico',
    'virtual': false,
    'cupos': 25,
  },
  {
    'nombre': 'Programación asíncrona: Future y Stream',
    'docente': 'MSc. Carolina Gómez',
    'duracion': 20,
    'nivel': 'Intermedio',
    'virtual': true,
    'cupos': 20,
  },
  {
    'nombre': 'Consumo de APIs REST',
    'docente': 'Ing. Julián Zapata',
    'duracion': 18,
    'nivel': 'Intermedio',
    'virtual': false,
    'cupos': 22,
  },
  {
    'nombre': 'Gestión de estado con Provider',
    'docente': 'MSc. Daniel Ospina',
    'duracion': 28,
    'nivel': 'Avanzado',
    'virtual': true,
    'cupos': 15,
  },
  {
    'nombre': 'Publicación en Play Store y App Store',
    'docente': 'Ing. Valentina Ríos',
    'duracion': 12,
    'nivel': 'Avanzado',
    'virtual': false,
    'cupos': 18,
  },
];

/// Simula una consulta a un servidor remoto.
///
/// - `Future<...>`: promete entregar la lista más adelante, no de inmediato.
/// - `async`: permite usar `await` dentro de la función.
/// - `await Future.delayed(...)`: pausa esta función sin bloquear la interfaz,
///   así la pantalla puede seguir mostrando el indicador de carga.
Future<List<Map<String, dynamic>>> obtenerCursos() async {
  await Future.delayed(tiempoDeCarga);
  return cursos;
}
