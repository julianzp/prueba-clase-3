import 'package:flutter/material.dart';

import '../data/course_data.dart';

/// Pantalla principal: controla la carga y la presentación del catálogo.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Se guarda el Future en el estado para no repetir la consulta
  // cada vez que Flutter reconstruye la pantalla.
  late Future<List<Map<String, dynamic>>> _cursosFuture;

  @override
  void initState() {
    super.initState();
    _cursosFuture = obtenerCursos();
  }

  /// Vuelve a ejecutar la consulta simulada (deslizar hacia abajo).
  Future<void> _recargar() async {
    final future = obtenerCursos();
    setState(() => _cursosFuture = future);
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de cursos ESEIT'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _cursosFuture,
        builder: (context, snapshot) {
          // 1. Mientras el Future no termina: indicador de carga.
          if (snapshot.connectionState != ConnectionState.done) {
            return const _Cargando();
          }

          // 2. Si el Future falló: mensaje de error.
          if (snapshot.hasError) {
            return Center(
              child: Text('No se pudo cargar el catálogo: ${snapshot.error}'),
            );
          }

          // 3. Future completado: se muestra la lista.
          final lista = snapshot.data ?? [];
          return RefreshIndicator(
            onRefresh: _recargar,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lista.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _Encabezado(total: lista.length);
                return _TarjetaCurso(curso: lista[index - 1]);
              },
            ),
          );
        },
      ),
    );
  }
}

class _Cargando extends StatelessWidget {
  const _Cargando();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Consultando cursos disponibles...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  const _Encabezado({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final texto = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Desarrollo móvil multiplataforma', style: texto.titleLarge),
          const SizedBox(height: 4),
          Text(
            '$total cursos disponibles · desliza hacia abajo para recargar',
            style: texto.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _TarjetaCurso extends StatelessWidget {
  const _TarjetaCurso({required this.curso});

  final Map<String, dynamic> curso;

  @override
  Widget build(BuildContext context) {
    // Se leen los valores del mapa con su tipo real.
    final String nombre = curso['nombre'];
    final String docente = curso['docente'];
    final int duracion = curso['duracion'];
    final String nivel = curso['nivel'];
    final bool virtual = curso['virtual'];
    final int cupos = curso['cupos'];

    final estiloNivel = _estiloPorNivel(nivel);
    final texto = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: estiloNivel.color.withValues(alpha: 0.15),
              child: Icon(estiloNivel.icono, color: estiloNivel.color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nombre, style: texto.titleMedium),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 16),
                      const SizedBox(width: 4),
                      Expanded(child: Text(docente, style: texto.bodyMedium)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      _Etiqueta(
                        icono: Icons.signal_cellular_alt,
                        texto: nivel,
                        color: estiloNivel.color,
                      ),
                      _Etiqueta(icono: Icons.schedule, texto: '$duracion h'),
                      _Etiqueta(
                        icono: virtual ? Icons.laptop : Icons.apartment,
                        texto: virtual ? 'Virtual' : 'Presencial',
                      ),
                      _Etiqueta(icono: Icons.group, texto: '$cupos cupos'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ({IconData icono, Color color}) _estiloPorNivel(String nivel) {
    switch (nivel) {
      case 'Básico':
        return (icono: Icons.school_outlined, color: Colors.green.shade700);
      case 'Intermedio':
        return (icono: Icons.trending_up, color: Colors.orange.shade800);
      default:
        return (icono: Icons.workspace_premium, color: Colors.red.shade700);
    }
  }
}

class _Etiqueta extends StatelessWidget {
  const _Etiqueta({required this.icono, required this.texto, this.color});

  final IconData icono;
  final String texto;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icono, size: 16, color: color),
      label: Text(texto),
      labelStyle: TextStyle(color: color),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
