// Archivo: lib/screens/stats_screen.dart
// (Versión corregida con TabBar/Slider)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

// Imports para el CSV
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos 'Consumer' para que la pantalla se reconstruya si cambian los datos
    return Consumer<AppState>(
      builder: (context, appState, child) {
        // --- SECCIÓN DE CÁLCULO DE TOTALES ---
        // (Esta lógica es la misma que antes)
        // T1 - Pena
        final golesT1Pena =
            appState.getStatT1(StatKeys.golPenaContra) +
            appState.getStatT1(StatKeys.golPena9m) +
            appState.getStatT1(StatKeys.golPena7m) +
            appState.getStatT1(StatKeys.golPena6m);
        final noGolesT1Pena =
            appState.getStatT1(StatKeys.noGolPenaContra) +
            appState.getStatT1(StatKeys.noGolPena9m) +
            appState.getStatT1(StatKeys.noGolPena7m) +
            appState.getStatT1(StatKeys.noGolPena6m);
        final pelotaPerdidasForzT1 = appState.getStatT1(
          StatKeys.pelotaPerdidaForzada,
        );
        final pelotaPerdidasNoForzT1 = appState.getStatT1(
          StatKeys.pelotaPerdidaNoForzada,
        );
        final pelotaRecupForzT1 = appState.getStatT1(
          StatKeys.pelotaRecuperadaForzada,
        );
        final pelotaRecupNoForzT1 = appState.getStatT1(
          StatKeys.pelotaRecuperadaNoForzada,
        );
        final exclusionesT1Pena = appState.getStatT1(StatKeys.exclusionPena);
        final exclusionesT1Rival = appState.getStatT1(StatKeys.exclusionRival);
        // T1 - Rival
        final golesT1Rival =
            appState.getStatT1(StatKeys.golRivalContra) +
            appState.getStatT1(StatKeys.golRival9m) +
            appState.getStatT1(StatKeys.golRival7m) +
            appState.getStatT1(StatKeys.golRival6m);
        final noGolesT1Rival =
            appState.getStatT1(StatKeys.noGolRivalContra) +
            appState.getStatT1(StatKeys.noGolRival9m) +
            appState.getStatT1(StatKeys.noGolRival7m) +
            appState.getStatT1(StatKeys.noGolRival6m);

        // T2 - Pena
        final golesT2Pena =
            appState.getStatT2(StatKeys.golPenaContra) +
            appState.getStatT2(StatKeys.golPena9m) +
            appState.getStatT2(StatKeys.golPena7m) +
            appState.getStatT2(StatKeys.golPena6m);
        final noGolesT2Pena =
            appState.getStatT2(StatKeys.noGolPenaContra) +
            appState.getStatT2(StatKeys.noGolPena9m) +
            appState.getStatT2(StatKeys.noGolPena7m) +
            appState.getStatT2(StatKeys.noGolPena6m);
        final pelotaPerdidasForzT2 = appState.getStatT2(
          StatKeys.pelotaPerdidaForzada,
        );
        final pelotaPerdidasNoForzT2 = appState.getStatT2(
          StatKeys.pelotaPerdidaNoForzada,
        );
        final pelotaRecupForzT2 = appState.getStatT2(
          StatKeys.pelotaRecuperadaForzada,
        );
        final pelotaRecupNoForzT2 = appState.getStatT2(
          StatKeys.pelotaRecuperadaNoForzada,
        );
        final exclusionesT2Pena = appState.getStatT2(StatKeys.exclusionPena);
        final exclusionesT2Rival = appState.getStatT2(StatKeys.exclusionRival);
        // T2 - Rival
        final golesT2Rival =
            appState.getStatT2(StatKeys.golRivalContra) +
            appState.getStatT2(StatKeys.golRival9m) +
            appState.getStatT2(StatKeys.golRival7m) +
            appState.getStatT2(StatKeys.golRival6m);
        final noGolesT2Rival =
            appState.getStatT2(StatKeys.noGolRivalContra) +
            appState.getStatT2(StatKeys.noGolRival9m) +
            appState.getStatT2(StatKeys.noGolRival7m) +
            appState.getStatT2(StatKeys.noGolRival6m);

        // --- NUEVA ESTRUCTURA CON TABS (SLIDER) ---
        return DefaultTabController(
          length: 3, // 3 pestañas
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Balance de Partido'),
              // Botón de Volver (automático por estar en otra ruta)
              bottom: const TabBar(
                tabs: [
                  Tab(text: '1ER TIEMPO'),
                  Tab(text: '2DO TIEMPO'),
                  Tab(text: 'BALANCE'),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 2.0, right: 2.0),
              child: TabBarView(
                children: [
                  // --- Pestaña 1: PRIMER TIEMPO ---
                  SingleChildScrollView(
                    child: _BuildTableColumn(
                      title: 'PRIMER TIEMPO',
                      golesPena: golesT1Pena,
                      noGolesPena: noGolesT1Pena,
                      // Nombres con 'P' Mayúscula para coincidir con tu widget
                      PenaContra: appState.getStatT1(StatKeys.golPenaContra),
                      PenaNoContra: appState.getStatT1(
                        StatKeys.noGolPenaContra,
                      ),
                      Pena6m: appState.getStatT1(StatKeys.golPena6m),
                      PenaNo6m: appState.getStatT1(StatKeys.noGolPena6m),
                      Pena7m: appState.getStatT1(StatKeys.golPena7m),
                      PenaNo7m: appState.getStatT1(StatKeys.noGolPena7m),
                      Pena9m: appState.getStatT1(StatKeys.golPena9m),
                      PenaNo9m: appState.getStatT1(StatKeys.noGolPena9m),
                      rivalAtajadasPena: appState.getStatT1(
                        StatKeys.atajadaRival,
                      ),
                      PenaAfuera: appState.getStatT1(StatKeys.noGolPenaAfuera),
                      PenaPalo: appState.getStatT1(StatKeys.noGolPenaPalo),
                      PenaPisa: appState.getStatT1(StatKeys.noGolPenaPisa),

                      golesRival: golesT1Rival,
                      noGolesRival: noGolesT1Rival,
                      rivalAtajadas: appState.getStatT1(
                        StatKeys.atajadaPena,
                      ), // Atajadas de Pena (fallos del rival)
                      rivalContra: appState.getStatT1(StatKeys.golRivalContra),
                      rivalNoContra: appState.getStatT1(
                        StatKeys.noGolRivalContra,
                      ),
                      rival6m: appState.getStatT1(StatKeys.golRival6m),
                      rivalNo6m: appState.getStatT1(StatKeys.noGolRival6m),
                      rival7m: appState.getStatT1(StatKeys.golRival7m),
                      rivalNo7m: appState.getStatT1(StatKeys.noGolRival7m),
                      rival9m: appState.getStatT1(StatKeys.golRival9m),
                      rivalNo9m: appState.getStatT1(StatKeys.noGolRival9m),

                      // nuevos contadores de detalle
                      rivalAfuera: appState.getStatT1(
                        StatKeys.noGolRivalAfuera,
                      ),
                      rivalPalo: appState.getStatT1(StatKeys.noGolRivalPalo),
                      rivalPisa: appState.getStatT1(StatKeys.noGolRivalPisa),
                      pelotaPerdidasForzada: pelotaPerdidasForzT1,
                      pelotaPerdidasNoForzada: pelotaPerdidasNoForzT1,
                      pelotaRecuperadasForzada: pelotaRecupForzT1,
                      pelotaRecuperadasNoForzada: pelotaRecupNoForzT1,
                      exclusionesPena: exclusionesT1Pena,
                      exclusionesRival: exclusionesT1Rival,
                    ),
                  ),

                  // --- Pestaña 2: SEGUNDO TIEMPO ---
                  SingleChildScrollView(
                    child: _BuildTableColumn(
                      title: 'SEGUNDO TIEMPO',
                      golesPena: golesT2Pena,
                      noGolesPena: noGolesT2Pena,
                      // Nombres con 'P' Mayúscula para coincidir con tu widget
                      PenaContra: appState.getStatT2(StatKeys.golPenaContra),
                      PenaNoContra: appState.getStatT2(
                        StatKeys.noGolPenaContra,
                      ),
                      Pena6m: appState.getStatT2(StatKeys.golPena6m),
                      PenaNo6m: appState.getStatT2(StatKeys.noGolPena6m),
                      Pena7m: appState.getStatT2(StatKeys.golPena7m),
                      PenaNo7m: appState.getStatT2(StatKeys.noGolPena7m),
                      Pena9m: appState.getStatT2(StatKeys.golPena9m),
                      PenaNo9m: appState.getStatT2(StatKeys.noGolPena9m),
                      rivalAtajadasPena: appState.getStatT2(
                        StatKeys.atajadaRival,
                      ),
                      PenaAfuera: appState.getStatT2(StatKeys.noGolPenaAfuera),
                      PenaPalo: appState.getStatT2(StatKeys.noGolPenaPalo),
                      PenaPisa: appState.getStatT2(StatKeys.noGolPenaPisa),

                      golesRival: golesT2Rival,
                      noGolesRival: noGolesT2Rival,
                      rivalAtajadas: appState.getStatT2(StatKeys.atajadaPena),
                      rivalContra: appState.getStatT2(StatKeys.golRivalContra),
                      rivalNoContra: appState.getStatT2(
                        StatKeys.noGolRivalContra,
                      ),
                      rival6m: appState.getStatT2(StatKeys.golRival6m),
                      rivalNo6m: appState.getStatT2(StatKeys.noGolRival6m),
                      rival7m: appState.getStatT2(StatKeys.golRival7m),
                      rivalNo7m: appState.getStatT2(StatKeys.noGolRival7m),
                      rival9m: appState.getStatT2(StatKeys.golRival9m),
                      rivalNo9m: appState.getStatT2(StatKeys.noGolRival9m),

                      rivalAfuera: appState.getStatT2(
                        StatKeys.noGolRivalAfuera,
                      ),
                      rivalPalo: appState.getStatT2(StatKeys.noGolRivalPalo),
                      rivalPisa: appState.getStatT2(StatKeys.noGolRivalPisa),
                      pelotaPerdidasForzada: pelotaPerdidasForzT2,
                      pelotaPerdidasNoForzada: pelotaPerdidasNoForzT2,
                      pelotaRecuperadasForzada: pelotaRecupForzT2,
                      pelotaRecuperadasNoForzada: pelotaRecupNoForzT2,
                      exclusionesPena: exclusionesT2Pena,
                      exclusionesRival: exclusionesT2Rival,
                    ),
                  ),

                  // --- Pestaña 3: BALANCE (1ro vs 2do) ---
                  SingleChildScrollView(
                    child: _BuildBalanceColumn(
                      // Goles Pena
                      penaContraT1: appState.getStatT1(StatKeys.golPenaContra),
                      penaContraT2: appState.getStatT2(StatKeys.golPenaContra),
                      pena6mT1: appState.getStatT1(StatKeys.golPena6m),
                      pena6mT2: appState.getStatT2(StatKeys.golPena6m),
                      pena7mT1: appState.getStatT1(StatKeys.golPena7m),
                      pena7mT2: appState.getStatT2(StatKeys.golPena7m),
                      pena9mT1: appState.getStatT1(StatKeys.golPena9m),
                      pena9mT2: appState.getStatT2(StatKeys.golPena9m),
                      // No Goles Pena
                      penaNoContraT1: appState.getStatT1(
                        StatKeys.noGolPenaContra,
                      ),
                      penaNoContraT2: appState.getStatT2(
                        StatKeys.noGolPenaContra,
                      ),
                      penaNo6mT1: appState.getStatT1(StatKeys.noGolPena6m),
                      penaNo6mT2: appState.getStatT2(StatKeys.noGolPena6m),
                      penaNo7mT1: appState.getStatT1(StatKeys.noGolPena7m),
                      penaNo7mT2: appState.getStatT2(StatKeys.noGolPena7m),
                      penaNo9mT1: appState.getStatT1(StatKeys.noGolPena9m),
                      penaNo9mT2: appState.getStatT2(StatKeys.noGolPena9m),
                      // Goles Rival
                      rivalContraT1: appState.getStatT1(
                        StatKeys.golRivalContra,
                      ),
                      rivalContraT2: appState.getStatT2(
                        StatKeys.golRivalContra,
                      ),
                      rival6mT1: appState.getStatT1(StatKeys.golRival6m),
                      rival6mT2: appState.getStatT2(StatKeys.golRival6m),
                      rival7mT1: appState.getStatT1(StatKeys.golRival7m),
                      rival7mT2: appState.getStatT2(StatKeys.golRival7m),
                      rival9mT1: appState.getStatT1(StatKeys.golRival9m),
                      rival9mT2: appState.getStatT2(StatKeys.golRival9m),
                      // No Goles Rival
                      rivalNoContraT1: appState.getStatT1(
                        StatKeys.noGolRivalContra,
                      ),
                      rivalNoContraT2: appState.getStatT2(
                        StatKeys.noGolRivalContra,
                      ),
                      rivalNo6mT1: appState.getStatT1(StatKeys.noGolRival6m),
                      rivalNo6mT2: appState.getStatT2(StatKeys.noGolRival6m),
                      rivalNo7mT1: appState.getStatT1(StatKeys.noGolRival7m),
                      rivalNo7mT2: appState.getStatT2(StatKeys.noGolRival7m),
                      rivalNo9mT1: appState.getStatT1(StatKeys.noGolRival9m),
                      rivalNo9mT2: appState.getStatT2(StatKeys.noGolRival9m),
                      // Atajadas
                      atajadasPenaT1: appState.getStatT1(StatKeys.atajadaPena),
                      atajadasPenaT2: appState.getStatT2(StatKeys.atajadaPena),
                      atajadasRivalT1: appState.getStatT1(
                        StatKeys.atajadaRival,
                      ),
                      atajadasRivalT2: appState.getStatT2(
                        StatKeys.atajadaRival,
                      ),
                      // Otros
                      PenaPerdidasT1:
                          appState.getStatT1(StatKeys.pelotaPerdidaForzada) +
                          appState.getStatT1(StatKeys.pelotaPerdidaNoForzada),
                      PenaPerdidasT2:
                          appState.getStatT2(StatKeys.pelotaPerdidaForzada) +
                          appState.getStatT2(StatKeys.pelotaPerdidaNoForzada),
                      PenaRecuperadasT1:
                          appState.getStatT1(StatKeys.pelotaRecuperadaForzada) +
                          appState.getStatT1(
                            StatKeys.pelotaRecuperadaNoForzada,
                          ),
                      PenaRecuperadasT2:
                          appState.getStatT2(StatKeys.pelotaRecuperadaForzada) +
                          appState.getStatT2(
                            StatKeys.pelotaRecuperadaNoForzada,
                          ),
                      PenaExclusionesT1:
                          appState.getStatT1(StatKeys.exclusionPena) +
                          appState.getStatT1(StatKeys.exclusionRival),
                      PenaExclusionesT2:
                          appState.getStatT2(StatKeys.exclusionPena) +
                          appState.getStatT2(StatKeys.exclusionRival),
                      RivalExclusionesT1: appState.getStatT1(
                        StatKeys.exclusionRival,
                      ),
                      RivalExclusionesT2: appState.getStatT2(
                        StatKeys.exclusionRival,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // --- BOTONES DE ACCIÓN (AHORA EN UN BOTTOM BAR) ---
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Volver al Hub'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                        ); // Vuelve a la pantalla anterior (Hub)
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.share),
                      label: const Text('Exportar CSV'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                      ),
                      onPressed: () {
                        // Llamamos a la función de exportar
                        _exportToCSV(context, appState);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- FUNCIÓN DE EXPORTAR CSV ---
  // (Esta parte es IDÉNTICA a la tuya, no se toca)

  // --- FUNCIÓN DE EXPORTAR CSV (VERSIÓN 2.0 CON BALANCE) ---

  Future<void> _exportToCSV(BuildContext context, AppState appState) async {
    // --- 1. Cálculos de Totales (para T1 y T2) ---
    // (Esto es lo que antes hacíamos en el 'build')
    final golesT1Pena =
        appState.getStatT1(StatKeys.golPenaContra) +
        appState.getStatT1(StatKeys.golPena9m) +
        appState.getStatT1(StatKeys.golPena7m) +
        appState.getStatT1(StatKeys.golPena6m);
    final noGolesT1Pena =
        appState.getStatT1(StatKeys.noGolPenaContra) +
        appState.getStatT1(StatKeys.noGolPena9m) +
        appState.getStatT1(StatKeys.noGolPena7m) +
        appState.getStatT1(StatKeys.noGolPena6m);
    final golesT1Rival =
        appState.getStatT1(StatKeys.golRivalContra) +
        appState.getStatT1(StatKeys.golRival9m) +
        appState.getStatT1(StatKeys.golRival7m) +
        appState.getStatT1(StatKeys.golRival6m);
    final noGolesT1Rival =
        appState.getStatT1(StatKeys.noGolRivalContra) +
        appState.getStatT1(StatKeys.noGolRival9m) +
        appState.getStatT1(StatKeys.noGolRival7m) +
        appState.getStatT1(StatKeys.noGolRival6m);
    final golesT2Pena =
        appState.getStatT2(StatKeys.golPenaContra) +
        appState.getStatT2(StatKeys.golPena9m) +
        appState.getStatT2(StatKeys.golPena7m) +
        appState.getStatT2(StatKeys.golPena6m);
    final noGolesT2Pena =
        appState.getStatT2(StatKeys.noGolPenaContra) +
        appState.getStatT2(StatKeys.noGolPena9m) +
        appState.getStatT2(StatKeys.noGolPena7m) +
        appState.getStatT2(StatKeys.noGolPena6m);
    // detalles adicionales
    final pelotaPerdidasForzT1 = appState.getStatT1(
      StatKeys.pelotaPerdidaForzada,
    );
    final pelotaPerdidasNoForzT1 = appState.getStatT1(
      StatKeys.pelotaPerdidaNoForzada,
    );
    final pelotaPerdidasForzT2 = appState.getStatT2(
      StatKeys.pelotaPerdidaForzada,
    );
    final pelotaPerdidasNoForzT2 = appState.getStatT2(
      StatKeys.pelotaPerdidaNoForzada,
    );
    final pelotaRecupForzT1 = appState.getStatT1(
      StatKeys.pelotaRecuperadaForzada,
    );
    final pelotaRecupNoForzT1 = appState.getStatT1(
      StatKeys.pelotaRecuperadaNoForzada,
    );
    final pelotaRecupForzT2 = appState.getStatT2(
      StatKeys.pelotaRecuperadaForzada,
    );
    final pelotaRecupNoForzT2 = appState.getStatT2(
      StatKeys.pelotaRecuperadaNoForzada,
    );
    final exclusionesT1Pena = appState.getStatT1(StatKeys.exclusionPena);
    final exclusionesT1Rival = appState.getStatT1(StatKeys.exclusionRival);
    final exclusionesT2Pena = appState.getStatT2(StatKeys.exclusionPena);
    final exclusionesT2Rival = appState.getStatT2(StatKeys.exclusionRival);
    final golesT2Rival =
        appState.getStatT2(StatKeys.golRivalContra) +
        appState.getStatT2(StatKeys.golRival9m) +
        appState.getStatT2(StatKeys.golRival7m) +
        appState.getStatT2(StatKeys.golRival6m);
    final noGolesT2Rival =
        appState.getStatT2(StatKeys.noGolRivalContra) +
        appState.getStatT2(StatKeys.noGolRival9m) +
        appState.getStatT2(StatKeys.noGolRival7m) +
        appState.getStatT2(StatKeys.noGolRival6m);

    // --- 2. Preparar los datos (Las filas del CSV) ---
    final List<List<dynamic>> rows = [];
    rows.add(['Estadísticas de Partido - Resumen']);
    rows.add(['']);

    // --- PRIMER TIEMPO ---
    rows.add(['PRIMER TIEMPO', 'Goles', 'No Goles']);
    rows.add(['Lanz. Peña', golesT1Pena, noGolesT1Pena]);
    rows.add(['- Atajadas Rival', appState.getStatT1(StatKeys.atajadaRival)]);
    rows.add([
      '- Contragolpe',
      appState.getStatT1(StatKeys.golPenaContra),
      appState.getStatT1(StatKeys.noGolPenaContra),
    ]);
    rows.add([
      '- 6 Metros',
      appState.getStatT1(StatKeys.golPena6m),
      appState.getStatT1(StatKeys.noGolPena6m),
    ]);
    rows.add([
      '- 7 Metros',
      appState.getStatT1(StatKeys.golPena7m),
      appState.getStatT1(StatKeys.noGolPena7m),
    ]);
    rows.add([
      '- 9 Metros',
      appState.getStatT1(StatKeys.golPena9m),
      appState.getStatT1(StatKeys.noGolPena9m),
    ]);
    rows.add(['']);
    // detalle de no-gol para Pena
    rows.add(['- Afuera (Peña)', appState.getStatT1(StatKeys.noGolPenaAfuera)]);
    rows.add(['- Palo (Peña)', appState.getStatT1(StatKeys.noGolPenaPalo)]);
    rows.add(['- Pisa (Peña)', appState.getStatT1(StatKeys.noGolPenaPisa)]);
    rows.add(['Lanz. Rival', golesT1Rival, noGolesT1Rival]);
    rows.add(['- Atajadas Pena', appState.getStatT1(StatKeys.atajadaPena)]);
    rows.add([
      '- Contragolpe',
      appState.getStatT1(StatKeys.golRivalContra),
      appState.getStatT1(StatKeys.noGolRivalContra),
    ]);
    rows.add([
      '- 6 Metros',
      appState.getStatT1(StatKeys.golRival6m),
      appState.getStatT1(StatKeys.noGolRival6m),
    ]);
    rows.add([
      '- 7 Metros',
      appState.getStatT1(StatKeys.golRival7m),
      appState.getStatT1(StatKeys.noGolRival7m),
    ]);
    rows.add([
      '- 9 Metros',
      appState.getStatT1(StatKeys.golRival9m),
      appState.getStatT1(StatKeys.noGolRival9m),
    ]);
    rows.add([
      '- Afuera (Rival)',
      appState.getStatT1(StatKeys.noGolRivalAfuera),
    ]);
    rows.add(['- Palo (Rival)', appState.getStatT1(StatKeys.noGolRivalPalo)]);
    rows.add(['- Pisa (Rival)', appState.getStatT1(StatKeys.noGolRivalPisa)]);
    rows.add(['']);
    rows.add(['Pelotas Perdidas (Peña) - Forzada', pelotaPerdidasForzT1]);
    rows.add(['Pelotas Perdidas (Peña) - No forzada', pelotaPerdidasNoForzT1]);
    rows.add(['Pelotas Recuperadas (Peña) - Forzada', pelotaRecupForzT1]);
    rows.add(['Pelotas Recuperadas (Peña) - No forzada', pelotaRecupNoForzT1]);
    rows.add(['Exclusiones (Peña)', exclusionesT1Pena]);
    rows.add(['Exclusiones (Rival)', exclusionesT1Rival]);
    rows.add(['']);
    rows.add(['---', '---', '---']);

    // --- SEGUNDO TIEMPO ---
    rows.add(['SEGUNDO TIEMPO', 'Goles', 'No Goles']);
    rows.add(['Lanz. Peña', golesT2Pena, noGolesT2Pena]);
    rows.add(['- Atajadas Rival', appState.getStatT2(StatKeys.atajadaRival)]);
    rows.add([
      '- Contragolpe',
      appState.getStatT2(StatKeys.golPenaContra),
      appState.getStatT2(StatKeys.noGolPenaContra),
    ]);
    rows.add([
      '- 6 Metros',
      appState.getStatT2(StatKeys.golPena6m),
      appState.getStatT2(StatKeys.noGolPena6m),
    ]);
    rows.add([
      '- 7 Metros',
      appState.getStatT2(StatKeys.golPena7m),
      appState.getStatT2(StatKeys.noGolPena7m),
    ]);
    rows.add([
      '- 9 Metros',
      appState.getStatT2(StatKeys.golPena9m),
      appState.getStatT2(StatKeys.noGolPena9m),
    ]);
    rows.add(['']);
    rows.add(['- Afuera (Peña)', appState.getStatT2(StatKeys.noGolPenaAfuera)]);
    rows.add(['- Palo (Peña)', appState.getStatT2(StatKeys.noGolPenaPalo)]);
    rows.add(['- Pisa (Peña)', appState.getStatT2(StatKeys.noGolPenaPisa)]);
    rows.add(['Lanz. Rival', golesT2Rival, noGolesT2Rival]);
    rows.add(['- Atajadas Pena', appState.getStatT2(StatKeys.atajadaPena)]);
    rows.add([
      '- Contragolpe',
      appState.getStatT2(StatKeys.golRivalContra),
      appState.getStatT2(StatKeys.noGolRivalContra),
    ]);
    rows.add([
      '- 6 Metros',
      appState.getStatT2(StatKeys.golRival6m),
      appState.getStatT2(StatKeys.noGolRival6m),
    ]);
    rows.add([
      '- 7 Metros',
      appState.getStatT2(StatKeys.golRival7m),
      appState.getStatT2(StatKeys.noGolRival7m),
    ]);
    rows.add([
      '- 9 Metros',
      appState.getStatT2(StatKeys.golRival9m),
      appState.getStatT2(StatKeys.noGolRival9m),
    ]);
    rows.add([
      '- Afuera (Rival)',
      appState.getStatT2(StatKeys.noGolRivalAfuera),
    ]);
    rows.add(['- Palo (Rival)', appState.getStatT2(StatKeys.noGolRivalPalo)]);
    rows.add(['- Pisa (Rival)', appState.getStatT2(StatKeys.noGolRivalPisa)]);
    rows.add(['']);
    rows.add(['Pelotas Perdidas (Peña) - Forzada', pelotaPerdidasForzT2]);
    rows.add(['Pelotas Perdidas (Peña) - No forzada', pelotaPerdidasNoForzT2]);
    rows.add(['Pelotas Recuperadas (Peña) - Forzada', pelotaRecupForzT2]);
    rows.add(['Pelotas Recuperadas (Peña) - No forzada', pelotaRecupNoForzT2]);
    rows.add(['Exclusiones (Peña)', exclusionesT2Pena]);
    rows.add(['Exclusiones (Rival)', exclusionesT2Rival]);
    rows.add(['']);
    rows.add(['---', '---', '---']);

    // --- ¡NUEVO! SECCIÓN DE BALANCE ---
    rows.add(['BALANCE (1ro vs 2do)']);
    rows.add(['Lanzamiento Peña']);
    rows.add([
      'G - Contragolpe',
      _comparar(
        appState.getStatT1(StatKeys.golPenaContra),
        appState.getStatT2(StatKeys.golPenaContra),
      )['texto'],
    ]);
    rows.add([
      'G - 6 Metros',
      _comparar(
        appState.getStatT1(StatKeys.golPena6m),
        appState.getStatT2(StatKeys.golPena6m),
      )['texto'],
    ]);
    rows.add([
      'G - 7 Metros',
      _comparar(
        appState.getStatT1(StatKeys.golPena7m),
        appState.getStatT2(StatKeys.golPena7m),
      )['texto'],
    ]);
    rows.add([
      'G - 9 Metros',
      _comparar(
        appState.getStatT1(StatKeys.golPena9m),
        appState.getStatT2(StatKeys.golPena9m),
      )['texto'],
    ]);
    rows.add([
      'NG - Contragolpe',
      _comparar(
        appState.getStatT1(StatKeys.noGolPenaContra),
        appState.getStatT2(StatKeys.noGolPenaContra),
      )['texto'],
    ]);
    rows.add([
      'NG - 6 Metros',
      _comparar(
        appState.getStatT1(StatKeys.noGolPena6m),
        appState.getStatT2(StatKeys.noGolPena6m),
      )['texto'],
    ]);
    rows.add([
      'NG - 7 Metros',
      _comparar(
        appState.getStatT1(StatKeys.noGolPena7m),
        appState.getStatT2(StatKeys.noGolPena7m),
      )['texto'],
    ]);
    rows.add([
      'NG - 9 Metros',
      _comparar(
        appState.getStatT1(StatKeys.noGolPena9m),
        appState.getStatT2(StatKeys.noGolPena9m),
      )['texto'],
    ]);
    rows.add([
      'Atajadas Rival',
      _comparar(
        appState.getStatT1(StatKeys.atajadaRival),
        appState.getStatT2(StatKeys.atajadaRival),
      )['texto'],
    ]);
    rows.add(['']);
    rows.add(['Lanzamiento Rival']);
    rows.add([
      'G - Contragolpe',
      _comparar(
        appState.getStatT1(StatKeys.golRivalContra),
        appState.getStatT2(StatKeys.golRivalContra),
      )['texto'],
    ]);
    rows.add([
      'G - 6 Metros',
      _comparar(
        appState.getStatT1(StatKeys.golRival6m),
        appState.getStatT2(StatKeys.golRival6m),
      )['texto'],
    ]);
    rows.add([
      'G - 7 Metros',
      _comparar(
        appState.getStatT1(StatKeys.golRival7m),
        appState.getStatT2(StatKeys.golRival7m),
      )['texto'],
    ]);
    rows.add([
      'G - 9 Metros',
      _comparar(
        appState.getStatT1(StatKeys.golRival9m),
        appState.getStatT2(StatKeys.golRival9m),
      )['texto'],
    ]);
    rows.add([
      'NG - Contragolpe',
      _comparar(
        appState.getStatT1(StatKeys.noGolRivalContra),
        appState.getStatT2(StatKeys.noGolRivalContra),
      )['texto'],
    ]);
    rows.add([
      'NG - 6 Metros',
      _comparar(
        appState.getStatT1(StatKeys.noGolRival6m),
        appState.getStatT2(StatKeys.noGolRival6m),
      )['texto'],
    ]);
    rows.add([
      'NG - 7 Metros',
      _comparar(
        appState.getStatT1(StatKeys.noGolRival7m),
        appState.getStatT2(StatKeys.noGolRival7m),
      )['texto'],
    ]);
    rows.add([
      'NG - 9 Metros',
      _comparar(
        appState.getStatT1(StatKeys.noGolRival9m),
        appState.getStatT2(StatKeys.noGolRival9m),
      )['texto'],
    ]);
    rows.add([
      'Atajadas Pena',
      _comparar(
        appState.getStatT1(StatKeys.atajadaPena),
        appState.getStatT2(StatKeys.atajadaPena),
      )['texto'],
    ]);
    rows.add(['']);
    rows.add(['Otras Stats (Pena)']);
    rows.add([
      'Pelotas Perdidas',
      _comparar(
        appState.getStatT1(StatKeys.pelotaPerdidaForzada) +
            appState.getStatT1(StatKeys.pelotaPerdidaNoForzada),
        appState.getStatT2(StatKeys.pelotaPerdidaForzada) +
            appState.getStatT2(StatKeys.pelotaPerdidaNoForzada),
      )['texto'],
    ]);
    rows.add([
      'Pelotas Recuperadas',
      _comparar(
        appState.getStatT1(StatKeys.pelotaRecuperadaForzada) +
            appState.getStatT1(StatKeys.pelotaRecuperadaNoForzada),
        appState.getStatT2(StatKeys.pelotaRecuperadaForzada) +
            appState.getStatT2(StatKeys.pelotaRecuperadaNoForzada),
      )['texto'],
    ]);
    rows.add([
      'Exclusiones',
      _comparar(
        appState.getStatT1(StatKeys.exclusionPena) +
            appState.getStatT1(StatKeys.exclusionRival),
        appState.getStatT2(StatKeys.exclusionPena) +
            appState.getStatT2(StatKeys.exclusionRival),
      )['texto'],
    ]);

    // --- 3. Convertir y Guardar ---
    final String csvString = const ListToCsvConverter().convert(rows);

    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/stats_partido.csv';
      final File file = File(filePath);
      await file.writeAsString(csvString);

      await Share.shareXFiles([
        XFile(filePath),
      ], text: 'Estadísticas del partido');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al exportar CSV: $e')));
    }
  }
}

// --- WIDGETS DE UI (Helpers para construir las tablas) ---
// (Esta parte es IDÉNTICA a la tuya, no se toca)

// Widget para las columnas T1 y T2
class _BuildTableColumn extends StatelessWidget {
  final String title;
  // Pena
  final int golesPena, noGolesPena;
  final int PenaContra, PenaNoContra;
  final int Pena6m, PenaNo6m;
  final int Pena7m, PenaNo7m;
  final int Pena9m, PenaNo9m;
  final int rivalAtajadasPena;
  // Detalle NG Pena
  final int PenaAfuera, PenaPalo, PenaPisa;
  // Rival
  final int golesRival, noGolesRival;
  final int rivalAtajadas;
  final int rivalContra, rivalNoContra;
  final int rival6m, rivalNo6m;
  final int rival7m, rivalNo7m;
  final int rival9m, rivalNo9m;
  // Detalle NG Rival
  final int rivalAfuera, rivalPalo, rivalPisa;
  // Otros
  final int pelotaPerdidasForzada, pelotaPerdidasNoForzada;
  final int pelotaRecuperadasForzada, pelotaRecuperadasNoForzada;
  final int exclusionesPena, exclusionesRival;

  const _BuildTableColumn({
    required this.title,
    required this.golesPena,
    required this.noGolesPena,
    required this.PenaContra,
    required this.PenaNoContra,
    required this.Pena6m,
    required this.PenaNo6m,
    required this.Pena7m,
    required this.PenaNo7m,
    required this.Pena9m,
    required this.PenaNo9m,
    required this.rivalAtajadasPena,
    required this.PenaAfuera,
    required this.PenaPalo,
    required this.PenaPisa,
    required this.golesRival,
    required this.noGolesRival,
    required this.rivalAtajadas,
    required this.rivalContra,
    required this.rivalNoContra,
    required this.rival6m,
    required this.rivalNo6m,
    required this.rival7m,
    required this.rivalNo7m,
    required this.rival9m,
    required this.rivalNo9m,
    required this.rivalAfuera,
    required this.rivalPalo,
    required this.rivalPisa,
    required this.pelotaPerdidasForzada,
    required this.pelotaPerdidasNoForzada,
    required this.pelotaRecuperadasForzada,
    required this.pelotaRecuperadasNoForzada,
    required this.exclusionesPena,
    required this.exclusionesRival,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.white54)),
      child: Column(
        children: [
          _HeaderCell(title),
          // --- Pena ---
          _TitleCell('Lanzamiento Peña'),
          _RowHeader(),
          _DataRow(
            text: 'Total',
            val1: golesPena,
            val2: noGolesPena,
            color: Colors.yellow.shade900,
          ),
          _DataRowSingle(text: 'Atajadas Rival', val1: rivalAtajadasPena),
          _DataRow(text: 'Contragolpe', val1: PenaContra, val2: PenaNoContra),
          _DataRow(text: '6 Metros', val1: Pena6m, val2: PenaNo6m),
          _DataRow(text: '7 Metros', val1: Pena7m, val2: PenaNo7m),
          _DataRow(text: '9 Metros', val1: Pena9m, val2: PenaNo9m),
          // detalle no gol
          _TitleCell('No Gol Detalle Pena'),
          _DataRowSingle(text: 'Afuera', val1: PenaAfuera),
          _DataRowSingle(text: 'Palo', val1: PenaPalo),
          _DataRowSingle(text: 'Pisa', val1: PenaPisa),
          // --- RIVAL ---
          _TitleCell('Lanzamiento Rival'),
          _RowHeader(),
          _DataRow(
            text: 'Total',
            val1: golesRival,
            val2: noGolesRival,
            color: Colors.yellow.shade900,
          ),
          _DataRowSingle(text: 'Atajadas Pena', val1: rivalAtajadas),
          _DataRow(text: 'Contragolpe', val1: rivalContra, val2: rivalNoContra),
          _DataRow(text: '6 Metros', val1: rival6m, val2: rivalNo6m),
          _DataRow(text: '7 Metros', val1: rival7m, val2: rivalNo7m),
          _DataRow(text: '9 Metros', val1: rival9m, val2: rivalNo9m),
          _TitleCell('No Gol Detalle Rival'),
          _DataRowSingle(text: 'Afuera', val1: rivalAfuera),
          _DataRowSingle(text: 'Palo', val1: rivalPalo),
          _DataRowSingle(text: 'Pisa', val1: rivalPisa),
          // --- OTROS ---
          _TitleCell('Pelotas Perdidas'),
          _DataRowSingle(text: 'Forzada', val1: pelotaPerdidasForzada),
          _DataRowSingle(text: 'No forzada', val1: pelotaPerdidasNoForzada),
          _TitleCell('Pelotas Recuperadas'),
          _DataRowSingle(text: 'Forzada', val1: pelotaRecuperadasForzada),
          _DataRowSingle(text: 'No forzada', val1: pelotaRecuperadasNoForzada),
          _TitleCell('Sanciones (Peña)'),
          _DataRowSingle(text: 'Exclusiones Peña', val1: exclusionesPena),
          _DataRowSingle(text: 'Exclusiones Rival', val1: exclusionesRival),
        ],
      ),
    );
  }
}

// Widget para la columna de BALANCE
class _BuildBalanceColumn extends StatelessWidget {
  // Stats de Pena
  final int penaContraT1, penaContraT2;
  final int pena6mT1, pena6mT2;
  final int pena7mT1, pena7mT2;
  final int pena9mT1, pena9mT2;
  final int penaNoContraT1, penaNoContraT2;
  final int penaNo6mT1, penaNo6mT2;
  final int penaNo7mT1, penaNo7mT2;
  final int penaNo9mT1, penaNo9mT2;

  // Stats de Rival
  final int rivalContraT1, rivalContraT2;
  final int rival6mT1, rival6mT2;
  final int rival7mT1, rival7mT2;
  final int rival9mT1, rival9mT2;
  final int rivalNoContraT1, rivalNoContraT2;
  final int rivalNo6mT1, rivalNo6mT2;
  final int rivalNo7mT1, rivalNo7mT2;
  final int rivalNo9mT1, rivalNo9mT2;

  // Atajadas
  final int atajadasPenaT1, atajadasPenaT2;
  final int atajadasRivalT1, atajadasRivalT2;

  // Otros
  final int PenaPerdidasT1, PenaPerdidasT2;
  final int PenaRecuperadasT1, PenaRecuperadasT2;
  final int PenaExclusionesT1, PenaExclusionesT2;
  final int RivalExclusionesT1, RivalExclusionesT2;

  const _BuildBalanceColumn({
    // Pena
    required this.penaContraT1,
    required this.penaContraT2,
    required this.pena6mT1,
    required this.pena6mT2,
    required this.pena7mT1,
    required this.pena7mT2,
    required this.pena9mT1,
    required this.pena9mT2,
    required this.penaNoContraT1,
    required this.penaNoContraT2,
    required this.penaNo6mT1,
    required this.penaNo6mT2,
    required this.penaNo7mT1,
    required this.penaNo7mT2,
    required this.penaNo9mT1,
    required this.penaNo9mT2,
    // Rival
    required this.rivalContraT1,
    required this.rivalContraT2,
    required this.rival6mT1,
    required this.rival6mT2,
    required this.rival7mT1,
    required this.rival7mT2,
    required this.rival9mT1,
    required this.rival9mT2,
    required this.rivalNoContraT1,
    required this.rivalNoContraT2,
    required this.rivalNo6mT1,
    required this.rivalNo6mT2,
    required this.rivalNo7mT1,
    required this.rivalNo7mT2,
    required this.rivalNo9mT1,
    required this.rivalNo9mT2,
    // Atajadas
    required this.atajadasPenaT1,
    required this.atajadasPenaT2,
    required this.atajadasRivalT1,
    required this.atajadasRivalT2,
    // Otros
    required this.PenaPerdidasT1,
    required this.PenaPerdidasT2,
    required this.PenaRecuperadasT1,
    required this.PenaRecuperadasT2,
    required this.PenaExclusionesT1,
    required this.PenaExclusionesT2,
    required this.RivalExclusionesT1,
    required this.RivalExclusionesT2,
  });

  @override
  Widget build(BuildContext context) {
    // --- Calculamos TODAS las comparaciones ---

    // Goles Pena
    final compPenaContra = _comparar(penaContraT1, penaContraT2);
    final compPena6m = _comparar(pena6mT1, pena6mT2);
    final compPena7m = _comparar(pena7mT1, pena7mT2);
    final compPena9m = _comparar(pena9mT1, pena9mT2);
    // No Goles Pena
    final compPenaNoContra = _comparar(penaNoContraT1, penaNoContraT2);
    final compPenaNo6m = _comparar(penaNo6mT1, penaNo6mT2);
    final compPenaNo7m = _comparar(penaNo7mT1, penaNo7mT2);
    final compPenaNo9m = _comparar(penaNo9mT1, penaNo9mT2);
    // Goles Rival
    final compRivalContra = _comparar(rivalContraT1, rivalContraT2);
    final compRival6m = _comparar(rival6mT1, rival6mT2);
    final compRival7m = _comparar(rival7mT1, rival7mT2);
    final compRival9m = _comparar(rival9mT1, rival9mT2);
    // No Goles Rival
    final compRivalNoContra = _comparar(rivalNoContraT1, rivalNoContraT2);
    final compRivalNo6m = _comparar(rivalNo6mT1, rivalNo6mT2);
    final compRivalNo7m = _comparar(rivalNo7mT1, rivalNo7mT2);
    final compRivalNo9m = _comparar(rivalNo9mT1, rivalNo9mT2);
    // Atajadas
    final compAtajadasPena = _comparar(atajadasPenaT1, atajadasPenaT2);
    final compAtajadasRival = _comparar(atajadasRivalT1, atajadasRivalT2);
    // Otros
    final compPerdidas = _comparar(PenaPerdidasT1, PenaPerdidasT2);
    final compRecuperadas = _comparar(PenaRecuperadasT1, PenaRecuperadasT2);
    final compExclusionesPena = _comparar(PenaExclusionesT1, PenaExclusionesT2);
    final compExclusionesRival = _comparar(
      RivalExclusionesT1,
      RivalExclusionesT2,
    );

    // --- Re-mapeamos los colores (Stats "Malas") ---
    // (Menos es MEJOR)
    Color colorMalo(Map<String, dynamic> data, int t1, int t2) {
      if (data['texto'] == 'IGUAL') return data['color']; // Naranja
      return t2 < t1
          ? Colors.green.shade800
          : Colors.red.shade800; // Verde si bajó
    }

    // (Menos es PEOR para el rival)
    Color colorMaloRival(Map<String, dynamic> data, int t1, int t2) {
      if (data['texto'] == 'IGUAL') return data['color']; // Naranja
      return t2 < t1
          ? Colors.red.shade800
          : Colors.green.shade800; // Rojo si bajó
    }

    // No Goles Pena
    final colorPenaNoContra = colorMalo(
      compPenaNoContra,
      penaNoContraT1,
      penaNoContraT2,
    );
    final colorPenaNo6m = colorMalo(compPenaNo6m, penaNo6mT1, penaNo6mT2);
    final colorPenaNo7m = colorMalo(compPenaNo7m, penaNo7mT1, penaNo7mT2);
    final colorPenaNo9m = colorMalo(compPenaNo9m, penaNo9mT1, penaNo9mT2);
    // No Goles Rival
    final colorRivalNoContra = colorMaloRival(
      compRivalNoContra,
      rivalNoContraT1,
      rivalNoContraT2,
    );
    final colorRivalNo6m = colorMaloRival(
      compRivalNo6m,
      rivalNo6mT1,
      rivalNo6mT2,
    );
    final colorRivalNo7m = colorMaloRival(
      compRivalNo7m,
      rivalNo7mT1,
      rivalNo7mT2,
    );
    final colorRivalNo9m = colorMaloRival(
      compRivalNo9m,
      rivalNo9mT1,
      rivalNo9mT2,
    );
    // Otros
    final colorPerdidas = colorMalo(
      compPerdidas,
      PenaPerdidasT1,
      PenaPerdidasT2,
    );
    final colorExclusionesPena = colorMalo(
      compExclusionesPena,
      PenaExclusionesT1,
      PenaExclusionesT2,
    );
    final colorExclusionesRival = colorMaloRival(
      compExclusionesRival,
      RivalExclusionesT1,
      RivalExclusionesT2,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.white54)),
      child: Column(
        children: [
          _HeaderCell('BALANCE (1ro vs 2do)'),

          // --- Pena ---
          _TitleCell('Lanzamiento Peña'),
          _BalanceRow(
            texto: 'G - Contragolpe',
            data: compPenaContra,
            color: compPenaContra['color'],
          ),
          _BalanceRow(
            texto: 'G - 6 Metros',
            data: compPena6m,
            color: compPena6m['color'],
          ),
          _BalanceRow(
            texto: 'G - 7 Metros',
            data: compPena7m,
            color: compPena7m['color'],
          ),
          _BalanceRow(
            texto: 'G - 9 Metros',
            data: compPena9m,
            color: compPena9m['color'],
          ),
          _BalanceRow(
            texto: 'NG - Contragolpe',
            data: compPenaNoContra,
            color: colorPenaNoContra,
          ),
          _BalanceRow(
            texto: 'NG - 6 Metros',
            data: compPenaNo6m,
            color: colorPenaNo6m,
          ),
          _BalanceRow(
            texto: 'NG - 7 Metros',
            data: compPenaNo7m,
            color: colorPenaNo7m,
          ),
          _BalanceRow(
            texto: 'NG - 9 Metros',
            data: compPenaNo9m,
            color: colorPenaNo9m,
          ),
          _BalanceRow(
            texto: 'Atajadas Rival',
            data: compAtajadasRival,
            color: compAtajadasRival['color'],
          ), // Atajadas rival es "bueno" si sube
          // --- RIVAL ---
          _TitleCell('Lanzamiento Rival'),
          _BalanceRow(
            texto: 'G - Contragolpe',
            data: compRivalContra,
            color: compRivalContra['color'],
          ),
          _BalanceRow(
            texto: 'G - 6 Metros',
            data: compRival6m,
            color: compRival6m['color'],
          ),
          _BalanceRow(
            texto: 'G - 7 Metros',
            data: compRival7m,
            color: compRival7m['color'],
          ),
          _BalanceRow(
            texto: 'G - 9 Metros',
            data: compRival9m,
            color: compRival9m['color'],
          ),
          _BalanceRow(
            texto: 'NG - Contragolpe',
            data: compRivalNoContra,
            color: colorRivalNoContra,
          ),
          _BalanceRow(
            texto: 'NG - 6 Metros',
            data: compRivalNo6m,
            color: colorRivalNo6m,
          ),
          _BalanceRow(
            texto: 'NG - 7 Metros',
            data: compRivalNo7m,
            color: colorRivalNo7m,
          ),
          _BalanceRow(
            texto: 'NG - 9 Metros',
            data: compRivalNo9m,
            color: colorRivalNo9m,
          ),
          _BalanceRow(
            texto: 'Atajadas Pena',
            data: compAtajadasPena,
            color: compAtajadasPena['color'],
          ),

          // --- OTROS ---
          _TitleCell('Pelotas Perdidas'),
          _BalanceRow(texto: 'Total', data: compPerdidas, color: colorPerdidas),

          _TitleCell('Pelotas Recuperadas'),
          _BalanceRow(
            texto: 'Total',
            data: compRecuperadas,
            color: compRecuperadas['color'],
          ),

          _TitleCell('Sanciones (Peña)'),
          _BalanceRow(
            texto: 'Exclusiones Peña',
            data: compExclusionesPena,
            color: colorExclusionesPena,
          ),
          _BalanceRow(
            texto: 'Exclusiones Rival',
            data: compExclusionesRival,
            color: colorExclusionesRival,
          ),
        ],
      ),
    );
  }
}

// --- Celdas individuales (Helpers) ---
// (Esta parte es IDÉNTICA a la tuya, no se toca)

class _HeaderCell extends StatelessWidget {
  final String title;
  const _HeaderCell(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade900,
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }
}

class _TitleCell extends StatelessWidget {
  final String title;
  const _TitleCell(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade800,
      padding: const EdgeInsets.all(3),
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }
}

class _RowHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 3, child: SizedBox.shrink()),
        Expanded(flex: 2, child: _ValueCell('G', Colors.yellow.shade900)),
        Expanded(flex: 2, child: _ValueCell('NG', Colors.yellow.shade900)),
      ],
    );
  }
}

class _DataRow extends StatelessWidget {
  final String text;
  final int val1;
  final int? val2; // Nulo para filas de un solo valor
  final Color? color;
  const _DataRow({
    required this.text,
    required this.val1,
    this.val2,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _TextCell(text)),
        Expanded(flex: 2, child: _ValueCell(val1.toString(), color)),
        Expanded(flex: 2, child: _ValueCell(val2?.toString() ?? '-', color)),
      ],
    );
  }
}

class _DataRowSingle extends StatelessWidget {
  final String text;
  final int val1;
  // final Color? color; // <-- Borrado
  const _DataRowSingle({
    required this.text,
    required this.val1,
  }); // <-- Borrado de aquí

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _TextCell(text)),
        Expanded(
          flex: 4, // Ocupa el espacio de las dos columnas
          child: _ValueCell(
            val1.toString(),
            null,
          ), // <-- Pasamos null directamente
        ),
      ],
    );
  }
}

class _BalanceRow extends StatelessWidget {
  final String texto;
  final Map<String, dynamic> data;
  final Color color;
  const _BalanceRow({
    required this.texto,
    required this.data,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _TextCell(texto)),
        Expanded(flex: 4, child: _ValueCell(data['texto'], color)),
      ],
    );
  }
}

class _TextCell extends StatelessWidget {
  final String text;
  const _TextCell(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade700)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 9)),
    );
  }
}
// Pega esto en lugar del _ValueCell que tenías

class _ValueCell extends StatelessWidget {
  final String text;
  final Color? color;
  const _ValueCell(this.text, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: color, // <--- BORRAMOS ESTA LÍNEA
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color, // <--- MOVIMOS EL COLOR AQUÍ DENTRO
        border: Border(right: BorderSide(color: Colors.grey.shade700)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Helper para comparar T1 vs T2
Map<String, dynamic> _comparar(int t1, int t2) {
  if (t1 == t2) return {'texto': 'IGUAL', 'color': Colors.orange.shade800};
  if (t2 > t1)
    return {
      'texto': '${t2 - t1}+',
      'color': Colors.green.shade800,
    }; // Mejoró o empeoró (verde)
  return {
    'texto': '${t1 - t2}-',
    'color': Colors.red.shade800,
  }; // Mejoró o empeoró (rojo)
}
