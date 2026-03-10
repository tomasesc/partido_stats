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
  void _procesarResultado(BuildContext context, String? detalle) {
    // Si detalle es null significa que fue atajada;
    // en ese caso sumamos la atajada y continuamos al selector de tipo.
    if (detalle == null) {
      // atajada: se suma la atajada y se va a elegir distancia
      if (equipo == Equipo.Pena) {
        Provider.of<AppState>(
          context,
          listen: false,
        ).incrementar(StatKeys.atajadaRival);
      } else {
        Provider.of<AppState>(
          context,
          listen: false,
        ).incrementar(StatKeys.atajadaPena);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoGolTipoScreen(equipo: equipo),
        ),
      );
    } else if (detalle == 'pisa') {
      // pisa se registra y se asume 6 metros
      String key = (equipo == Equipo.Pena)
          ? StatKeys.noGolPenaPisa
          : StatKeys.noGolRivalPisa;
      Provider.of<AppState>(context, listen: false).incrementar(key);
      // agregar distancia 6m
      String distKey = (equipo == Equipo.Pena)
          ? StatKeys.noGolPena6m
          : StatKeys.noGolRival6m;
      Provider.of<AppState>(context, listen: false).incrementar(distKey);
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      // fuera o palo: registramos detalle y luego consultamos distancia
      String key;
      if (equipo == Equipo.Pena) {
        key = (detalle == 'afuera')
            ? StatKeys.noGolPenaAfuera
            : StatKeys.noGolPenaPalo;
      } else {
        key = (detalle == 'afuera')
            ? StatKeys.noGolRivalAfuera
            : StatKeys.noGolRivalPalo;
      }
      Provider.of<AppState>(context, listen: false).incrementar(key);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoGolTipoScreen(equipo: equipo),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definimos el color según el equipo
    final Color appBarColor = (equipo == Equipo.Pena)
        ? Colors.green.shade800
        : Colors.red.shade800;

    final String equipoNombre = (equipo == Equipo.Pena) ? "Peña" : "RIVAL";

    return Scaffold(
      appBar: AppBar(
        title: Text('Paso 3: Resultado del lanzamiento ($equipoNombre)'),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              '¿Qué ocurrió con el lanzamiento?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: (equipo == Equipo.Pena)
                    ? Colors.yellow.shade600
                    : Colors.green.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('Atajada', style: TextStyle(fontSize: 24)),
              onPressed: () {
                _procesarResultado(context, null);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('Afuera', style: TextStyle(fontSize: 24)),
              onPressed: () {
                _procesarResultado(context, 'afuera');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('Palo', style: TextStyle(fontSize: 24)),
              onPressed: () {
                _procesarResultado(context, 'palo');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('Pisa', style: TextStyle(fontSize: 24)),
              onPressed: () {
                _procesarResultado(context, 'pisa');
              },
            ),
          ],
        ),
      ),
    );
  }
}
