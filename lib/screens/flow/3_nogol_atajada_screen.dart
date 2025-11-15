// Archivo: lib/screens/flow/3_nogol_atajada_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '1_equipo_screen.dart'; // Para el enum Equipo
import '../../app_state.dart'; // Para AppState y StatKeys

// Importamos la siguiente (y última) pantalla del flujo
// MARCARÁ ERROR, es normal
import '4_nogol_tipo_screen.dart'; 

class NoGolAtajadaScreen extends StatelessWidget {
  // Recibimos el equipo que seleccionamos
  final Equipo equipo;
  
  const NoGolAtajadaScreen({super.key, required this.equipo});

  // Esta función es la que navega al siguiente paso
  void _navegarATipoDeFallo(BuildContext context, bool fueAtajada) {
    
    // Si fue atajada, sumamos el contador de atajada AL EQUIPO CONTRARIO
    if (fueAtajada) {
      if (equipo == Equipo.Pena) {
        // Lanzó Pena, atajó el Rival
        Provider.of<AppState>(context, listen: false)
          .incrementar(StatKeys.atajadaRival);
      } else {
        // Lanzó el Rival, atajó Pena
        Provider.of<AppState>(context, listen: false)
          .incrementar(StatKeys.atajadaPena);
      }
    }

    // Ahora, navegamos a la pantalla de "Tipos de Fallo"
    Navigator.push(
      context,
      MaterialPageRoute(
        // Le pasamos el equipo que falló
        builder: (context) => NoGolTipoScreen(equipo: equipo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definimos el color según el equipo
    final Color appBarColor = (equipo == Equipo.Pena) 
      ? Colors.green.shade800 
      : Colors.red.shade800;
      
    final String equipoNombre = (equipo == Equipo.Pena) ? "Pena" : "RIVAL";

    return Scaffold(
      appBar: AppBar(
        title: Text('Paso 3: ¿Atajada? ($equipoNombre)'),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              '¿El lanzamiento fue atajado por el arquero?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            // Botón "SI"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('SÍ (Fue atajada)', style: TextStyle(fontSize: 24)),
              onPressed: () {
                // Suma +1 atajada y navega
                _navegarATipoDeFallo(context, true);
              },
            ),
            
            const SizedBox(height: 30),
            
            // Botón "NO"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('NO (Fue afuera/palo)', style: TextStyle(fontSize: 24)),
              onPressed: () {
                // Solo navega
                _navegarATipoDeFallo(context, false);
              },
            ),
          ],
        ),
      ),
    );
  }
}