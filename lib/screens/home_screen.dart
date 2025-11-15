// Archivo: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart'; // Importamos el cerebro

// Importamos la primera pantalla del flujo de lanzamiento
// MARCARÁ ERROR, es normal, la crearemos en el Paso 6
import 'flow/1_equipo_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos un 'Consumer' para que el texto del AppBar se actualice
    // cuando cambiemos de periodo.
    return Consumer<AppState>(
      builder: (context, appState, child) {
        
        final periodo = (appState.periodoActual == Periodo.primero) 
          ? "PRIMER TIEMPO" 
          : "SEGUNDO TIEMPO";
          
        final esPrimerTiempo = appState.periodoActual == Periodo.primero;

        return Scaffold(
          appBar: AppBar(
            title: Text('Estadísticas - $periodo'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  // --- BOTONES DE ACCIÓN RÁPIDA ---
                  Text(
                    'Acciones Rápidas', 
                    style: Theme.of(context).textTheme.headlineSmall
                  ),
                  const SizedBox(height: 12),
                  
                  _BotonAccionRapida(
                    texto: 'Pelota Perdida',
                    icono: Icons.arrow_downward,
                    color: Colors.orange,
                    onPressed: () {
                      appState.incrementar(StatKeys.pelotaPerdida);
                      _mostrarSnackbar(context, 'Pelota Perdida (+1)');
                    },
                  ),
                  _BotonAccionRapida(
                    texto: 'Pelota Recuperada',
                    icono: Icons.arrow_upward,
                    color: Colors.green,
                    onPressed: () {
                      appState.incrementar(StatKeys.pelotaRecuperada);
                      _mostrarSnackbar(context, 'Pelota Recuperada (+1)');
                    },
                  ),
                  _BotonAccionRapida(
                    texto: 'Exclusión',
                    icono: Icons.timer,
                    color: Colors.yellow.shade700,
                    onPressed: () {
                      appState.incrementar(StatKeys.exclusion);
                      _mostrarSnackbar(context, 'Exclusión (+1)');
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white24, thickness: 1),
                  const SizedBox(height: 16),
                  
                  // --- BOTONES DE NAVEGACIÓN ---
                  
                  // Botón de Lanzamiento (inicia el flujo)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.ads_click, size: 28),
                    label: const Text('Lanzamiento al Arco'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: () {
                      // Navegamos a la primera pantalla del flujo
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EquipoScreen(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Botón de Ver Estadísticas
                  ElevatedButton.icon(
                    icon: const Icon(Icons.bar_chart, size: 28),
                    label: const Text('Ver Estadísticas'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/stats');
                    },
                  ),

                  const SizedBox(height: 30),
                  
                  // Botón de Pasar a 2do Tiempo
                  if (esPrimerTiempo) // Solo se muestra en el primer tiempo
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child: const Text('Pasar a 2do Tiempo'),
                      onPressed: () {
                        // Mostramos un diálogo de confirmación
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Confirmar'),
                            content: const Text('¿Seguro que quieres pasar al segundo tiempo? Esta acción no se puede deshacer.'),
                            actions: [
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                              TextButton(
                                child: const Text('Sí, pasar'),
                                onPressed: () {
                                  appState.pasarASegundoTiempo();
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Widgets Internos (Helpers) ---

  // Función para mostrar un aviso rápido
  void _mostrarSnackbar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

// Widget personalizado para los botones de acción rápida
class _BotonAccionRapida extends StatelessWidget {
  final String texto;
  final IconData icono;
  final Color color;
  final VoidCallback onPressed;

  const _BotonAccionRapida({
    required this.texto,
    required this.icono,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icono, color: color, size: 28),
              const SizedBox(width: 16),
              Text(texto, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}