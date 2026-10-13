import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

/// Punto de entrada de la aplicación.
void main() {
  runApp(const CatalogoCursosApp());
}

class CatalogoCursosApp extends StatelessWidget {
  const CatalogoCursosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de cursos ESEIT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
