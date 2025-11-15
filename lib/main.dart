// Archivo: lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; // Importamos el cerebro

// Importamos las pantallas (aún no existen, no te preocupes)
import 'screens/home_screen.dart';
import 'screens/stats_screen.dart';

void main() {
  runApp(
    // Envolvemos la app con el "Proveedor" de nuestro estado
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stats Handball',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E), // Fondo oscuro
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF333333),
          foregroundColor: Colors.white,
        ),
        // Estilo de botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        // Estilo de tarjetas
        cardTheme: const CardThemeData(
          color: Color(0xFF2C2C2C),
          elevation: 3,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      debugShowCheckedModeBanner: false,
      
      // Definimos nuestras pantallas (rutas)
      initialRoute: '/',
      routes: {
        // La pantalla 2 del diagrama será nuestra ruta '/'
        '/': (context) => const HomeScreen(), 
        // La pantalla 4 del diagrama (estadísticas)
        '/stats': (context) => const StatsScreen(), 
      },
    );
  }
}