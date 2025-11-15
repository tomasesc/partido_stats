// Archivo: lib/screens/flow/1_equipo_screen.dart

import 'package:flutter/material.dart';

// Importamos la siguiente pantalla del flujo
// MARCARÁ ERROR, es normal, la crearemos después
import '2_resultado_screen.dart';

// Definimos los equipos para pasarlos a la siguiente pantalla
enum Equipo { Pena, rival }

class EquipoScreen extends StatelessWidget {
  const EquipoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 1: ¿Quién lanza?'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              'Selecciona el equipo que realiza el lanzamiento:',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            // Botón "Pena"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('Pena', style: TextStyle(fontSize: 24)),
              onPressed: () {
                // Navegamos al Paso 2, pasando el equipo "Pena"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResultadoScreen(equipo: Equipo.Pena),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 30),
            
            // Botón "Rival"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('RIVAL', style: TextStyle(fontSize: 24)),
              onPressed: () {
                // Navegamos al Paso 2, pasando el equipo "Rival"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResultadoScreen(equipo: Equipo.rival),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}