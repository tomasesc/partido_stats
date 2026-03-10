// Archivo: lib/app_state.dart

import 'package:flutter/foundation.dart';

// Definimos los dos periodos del partido
enum Periodo { primero, segundo }

// Esta clase contendrá TODOS los datos y la lógica
class AppState extends ChangeNotifier {
  // Variable que controla en qué tiempo estamos
  Periodo _periodoActual = Periodo.primero;

  // Dos "cajas" separadas para guardar los datos de cada tiempo
  final Map<String, int> _statsT1 = {};
  final Map<String, int> _statsT2 = {};

  // --- Getters (Para leer los datos desde la UI) ---

  Periodo get periodoActual => _periodoActual;

  // Función para obtener un dato del T1 (si no existe, devuelve 0)
  int getStatT1(String key) => _statsT1[key] ?? 0;

  // Función para obtener un dato del T2 (si no existe, devuelve 0)
  int getStatT2(String key) => _statsT2[key] ?? 0;

  // --- Acciones (Para modificar los datos) ---

  // La acción del botón "Pasar a 2do Tiempo"
  void pasarASegundoTiempo() {
    if (_periodoActual == Periodo.primero) {
      _periodoActual = Periodo.segundo;
      notifyListeners(); // Avisa a la UI que el periodo cambió
    }
  }

  // La función MÁGICA. Incrementa el contador correcto
  // basado en el periodo actual.
  void incrementar(String statKey) {
    if (_periodoActual == Periodo.primero) {
      // Estamos en T1, sumamos a la caja _statsT1
      _statsT1[statKey] = (_statsT1[statKey] ?? 0) + 1;
    } else {
      // Estamos en T2, sumamos a la caja _statsT2
      _statsT2[statKey] = (_statsT2[statKey] ?? 0) + 1;
    }
    // además actualizamos las claves "antiguas" para mantener
    // compatibilidad con datos previos o consultas directas.
    if (statKey == StatKeys.pelotaPerdidaForzada ||
        statKey == StatKeys.pelotaPerdidaNoForzada) {
      // agregar también al contador global de pelotaPerdida
      if (_periodoActual == Periodo.primero) {
        _statsT1[StatKeys.pelotaPerdida] =
            (_statsT1[StatKeys.pelotaPerdida] ?? 0) + 1;
      } else {
        _statsT2[StatKeys.pelotaPerdida] =
            (_statsT2[StatKeys.pelotaPerdida] ?? 0) + 1;
      }
    }
    if (statKey == StatKeys.pelotaRecuperadaForzada ||
        statKey == StatKeys.pelotaRecuperadaNoForzada) {
      if (_periodoActual == Periodo.primero) {
        _statsT1[StatKeys.pelotaRecuperada] =
            (_statsT1[StatKeys.pelotaRecuperada] ?? 0) + 1;
      } else {
        _statsT2[StatKeys.pelotaRecuperada] =
            (_statsT2[StatKeys.pelotaRecuperada] ?? 0) + 1;
      }
    }
    if (statKey == StatKeys.exclusionPena ||
        statKey == StatKeys.exclusionRival) {
      if (_periodoActual == Periodo.primero) {
        _statsT1[StatKeys.exclusion] = (_statsT1[StatKeys.exclusion] ?? 0) + 1;
      } else {
        _statsT2[StatKeys.exclusion] = (_statsT2[StatKeys.exclusion] ?? 0) + 1;
      }
    }

    // Avisa a la UI que un número cambió (para la pantalla de stats)
    notifyListeners();
  }

  // Función para reiniciar todo (para un futuro botón de "nuevo partido")
  void reiniciarPartido() {
    _periodoActual = Periodo.primero;
    _statsT1.clear();
    _statsT2.clear();
    notifyListeners();
  }
}

// --- CLAVES DE ESTADÍSTICAS ---
// No necesitas tocar esto, es para que no nos equivoquemos
// al escribir las claves.
class StatKeys {
  // Acciones Rápidas
  static const pelotaPerdida = 'pelota_perdida';
  static const pelotaRecuperada = 'pelota_recuperada';
  static const exclusion = 'exclusion';
  // versiones nuevas: distinguen equipo (peña/rival) y tipo forzado
  static const exclusionPena = 'exclusion_pena';
  static const exclusionRival = 'exclusion_rival';

  static const pelotaPerdidaForzada = 'pelota_perdida_forzada';
  static const pelotaPerdidaNoForzada = 'pelota_perdida_noforzada';
  static const pelotaRecuperadaForzada = 'pelota_recuperada_forzada';
  static const pelotaRecuperadaNoForzada = 'pelota_recuperada_noforzada';

  // Stats de "Pena" (nuestro equipo)
  static const golPenaContra = 'gol_Pena_contra';
  static const golPena9m = 'gol_Pena_9m';
  static const golPena7m = 'gol_Pena_7m';
  static const golPena6m = 'gol_Pena_6m';

  static const noGolPenaContra = 'nogol_Pena_contra';
  static const noGolPena9m = 'nogol_Pena_9m';
  static const noGolPena7m = 'nogol_Pena_7m';
  static const noGolPena6m = 'nogol_Pena_6m';
  // detalle de no gol cuando no fue atajada
  static const noGolPenaAfuera = 'nogol_Pena_afuera';
  static const noGolPenaPalo = 'nogol_Pena_palo';
  static const noGolPenaPisa = 'nogol_Pena_pisa';

  // Stats de "RIVAL"
  static const golRivalContra = 'gol_rival_contra';
  static const golRival9m = 'gol_rival_9m';
  static const golRival7m = 'gol_rival_7m';
  static const golRival6m = 'gol_rival_6m';

  static const noGolRivalContra = 'nogol_rival_contra';
  static const noGolRival9m = 'nogol_rival_9m';
  static const noGolRival7m = 'nogol_rival_7m';
  static const noGolRival6m = 'nogol_rival_6m';
  static const noGolRivalAfuera = 'nogol_rival_afuera';
  static const noGolRivalPalo = 'nogol_rival_palo';
  static const noGolRivalPisa = 'nogol_rival_pisa';

  // Atajadas (se suman al equipo que ataja)
  static const atajadaPena = 'atajada_Pena';
  static const atajadaRival = 'atajada_rival';
}
