// Archivo: lib/screens/flow/pelota_perdida_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';

class PelotaPerdidaScreen extends StatelessWidget {
  const PelotaPerdidaScreen({super.key});

  void _registrar(BuildContext context, String statKey) {
    Provider.of<AppState>(context, listen: false).incrementar(statKey);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Pelota perdida registrada')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pelota Perdida'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              '¿La pérdida fue forzada?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('Forzada', style: TextStyle(fontSize: 24)),
              onPressed: () {
                _registrar(context, StatKeys.pelotaPerdidaForzada);
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                padding: const EdgeInsets.symmetric(vertical: 30),
              ),
              child: const Text('No forzada', style: TextStyle(fontSize: 24)),
              onPressed: () {
                _registrar(context, StatKeys.pelotaPerdidaNoForzada);
              },
            ),
          ],
        ),
      ),
    );
  }
}
