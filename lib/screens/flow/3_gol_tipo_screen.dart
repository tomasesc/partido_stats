// Archivo: lib/screens/flow/3_gol_tipo_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '1_equipo_screen.dart'; // Para el enum Equipo
import '../../app_state.dart'; // Para el AppState y StatKeys

class GolTipoScreen extends StatelessWidget {
  // Recibimos el equipo que seleccionamos
  final Equipo equipo;

  const GolTipoScreen({super.key, required this.equipo});

  // Esta función registra la estadística Y nos saca del flujo
  void _registrarGol(BuildContext context, String statKey) {
    // 1. Le pedimos al AppState que sume el contador
    // El 'listen: false' es importante aquí porque solo estamos llamando a una función
    Provider.of<AppState>(context, listen: false).incrementar(statKey);

    // 2. Volvemos al "Hub" (HomeScreen)
    // Esto cierra todas las pantallas del flujo (Equipo, Resultado, TipoGol) de una vez.
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    // Definimos el color según el equipo
    final Color appBarColor = (equipo == Equipo.Pena) 
      ? Colors.green.shade800 
      : Colors.red.shade800;
      
    final String equipoNombre = (equipo == Equipo.Pena) ? "Pena" : "RIVAL";
    
    // Definimos las claves de estadísticas correctas según el equipo
    final keys = (equipo == Equipo.Pena) 
      ? {
          'contra': StatKeys.golPenaContra,
          '9m': StatKeys.golPena9m,
          '7m': StatKeys.golPena7m,
          '6m': StatKeys.golPena6m,
        }
      : {
          'contra': StatKeys.golRivalContra,
          '9m': StatKeys.golRival9m,
          '7m': StatKeys.golRival7m,
          '6m': StatKeys.golRival6m,
        };

    return Scaffold(
      appBar: AppBar(
        title: Text('Paso 3: Tipo de GOL ($equipoNombre)'),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Text(
              'Selecciona el tipo de gol:',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            _BotonTipo(
              texto: 'Contragolpe',
              onPressed: () => _registrarGol(context, keys['contra']!),
            ),
            _BotonTipo(
              texto: '9 Metros',
              onPressed: () => _registrarGol(context, keys['9m']!),
            ),
            _BotonTipo(
              texto: '7 Metros (Penal)',
              onPressed: () => _registrarGol(context, keys['7m']!),
            ),
            _BotonTipo(
              texto: '6 Metros (Pivote/Extremo)',
              onPressed: () => _registrarGol(context, keys['6m']!),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget helper para los botones de esta pantalla
class _BotonTipo extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  
  const _BotonTipo({required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C2C2C), // Color de tarjeta
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white38),
          padding: const EdgeInsets.symmetric(vertical: 25),
        ),
        child: Text(texto, style: const TextStyle(fontSize: 18)),
        onPressed: onPressed,
      ),
    );
  }
}