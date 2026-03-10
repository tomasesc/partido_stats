// Archivo: lib/screens/flow/2_resultado_screen.dart

import 'package:flutter/material.dart';
import '1_equipo_screen.dart'; // Importamos el enum Equipo

// Importamos las DOS posibles pantallas siguientes
// AMBAS MARCARÁN ERROR, es normal
import '3_gol_tipo_screen.dart';
import '3_nogol_atajada_screen.dart';

class ResultadoScreen extends StatelessWidget {
  // Recibimos el equipo que seleccionamos en la pantalla anterior
  final Equipo equipo;
  
  const ResultadoScreen({super.key, required this.equipo});

  @override
  Widget build(BuildContext context) {
    // Definimos el color según el equipo
    final Color appBarColor = (equipo == Equipo.Pena) 
      ? Colors.green.shade800 
      : Colors.red.shade800;
      
    final String equipoNombre = (equipo == Equipo.Pena) ? "Peña" : "RIVAL";

    return Scaffold(
      appBar: AppBar(
        title: Text('Paso 2: ¿Resultado? ($equipoNombre)'),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              '¿El lanzamiento fue GOL o NO GOL?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            // Botón "GOL"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('GOL', style: TextStyle(fontSize: 24)),
              onPressed: () {
                // Navegamos al Paso 3 - Flujo de GOL
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GolTipoScreen(equipo: equipo),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 30),
            
            // Botón "NO GOL"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('NO GOL', style: TextStyle(fontSize: 24)),
              onPressed: () {
                // Navegamos al Paso 3 - Flujo de NO GOL
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoGolAtajadaScreen(equipo: equipo),
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