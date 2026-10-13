import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:catalogo_cursos/data/course_data.dart';
import 'package:catalogo_cursos/main.dart';

void main() {
  test('obtenerCursos devuelve la colección tipada completa', () async {
    final resultado = await obtenerCursos();

    expect(resultado, hasLength(greaterThanOrEqualTo(4)));
    for (final curso in resultado) {
      expect(curso['nombre'], isA<String>());
      expect(curso['docente'], isA<String>());
      expect(curso['duracion'], isA<int>());
      expect(curso['nivel'], isA<String>());
    }
  });

  testWidgets('muestra el indicador de carga y luego los cursos', (
    tester,
  ) async {
    await tester.pumpWidget(const CatalogoCursosApp());

    expect(find.text('Catálogo de cursos ESEIT'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Fundamentos de Dart'), findsNothing);

    await tester.pump(tiempoDeCarga);
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Fundamentos de Dart'), findsOneWidget);
  });
}
