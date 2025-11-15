// Archivo: lib/screens/flow/4_nogol_tipo_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '1_equipo_screen.dart'; // Para el enum Equipo
import '../../app_state.dart'; // Para el AppState y StatKeys

class NoGolTipoScreen extends StatelessWidget {
  // Recibimos el equipo que seleccionamos
  final Equipo equipo;

  const NoGolTipoScreen({super.key, required this.equipo});

  // Esta función registra la estadística Y nos saca del flujo
  void _registrarFallo(BuildContext context, String statKey) {
    // 1. Le pedimos al AppState que sume el contador
    Provider.of<AppState>(context, listen: false).incrementar(statKey);

    // 2. Volvemos al "Hub" (HomeScreen)
    // Cierra todas las pantallas del flujo (Equipo, Resultado, Atajada, TipoFallo)
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
          'contra': StatKeys.noGolPenaContra,
          '9m': StatKeys.noGolPena9m,
          '7m': StatKeys.noGolPena7m,
          '6m': StatKeys.noGolPena6m,
        }
      : {
          'contra': StatKeys.noGolRivalContra,
          '9m': StatKeys.noGolRival9m,
          '7m': StatKeys.noGolRival7m,
          '6m': StatKeys.noGolRival6m,
        };

    return Scaffold(
      appBar: AppBar(
        title: Text('Paso 4: Tipo de FALLO ($equipoNombre)'),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Text(
              'Selecciona el tipo de lanzamiento fallado:',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            _BotonTipo(
              texto: 'Contragolpe',
              onPressed: () => _registrarFallo(context, keys['contra']!),
            ),
            _BotonTipo(
              texto: '9 Metros',
              onPressed: () => _registrarFallo(context, keys['9m']!),
            ),
            _BotonTipo(
              texto: '7 Metros (Penal)',
              onPressed: () => _registrarFallo(context, keys['7m']!),
            ),
            _BotonTipo(
              texto: '6 Metros (Pivote/Extremo)',
              onPressed: () => _registrarFallo(context, keys['6m']!),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget helper para los botones de esta pantalla
// Es idéntico al de la pantalla de GOL
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