// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// 'material.dart' isn't needed directly in this test
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

// import app state for provider
import 'package:partido_stats/app_state.dart';

import 'package:partido_stats/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app with the provider, as main does.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const MyApp(),
      ),
    );

    // The home screen should show some of the expected labels.
    expect(find.text('Acciones Rápidas'), findsOneWidget);
    expect(find.text('Pelota Perdida'), findsOneWidget);
    expect(find.text('Exclusión Peña'), findsOneWidget);

    // navigate to statistics screen and verify a header changed
    await tester.tap(find.text('Ver Estadísticas'));
    await tester.pumpAndSettle();
    expect(find.text('No Gol Detalle Peña'), findsOneWidget);
  });

  test('pisa increment logic updates both counters', () {
    final appState = AppState();
    // simulate a pisa fallo en el primer tiempo
    appState.incrementar(StatKeys.noGolPenaPisa);
    appState.incrementar(StatKeys.noGolPena6m);
    expect(appState.getStatT1(StatKeys.noGolPenaPisa), 1);
    expect(appState.getStatT1(StatKeys.noGolPena6m), 1);
    // other stats should remain zero
    expect(appState.getStatT1(StatKeys.noGolPenaAfuera), 0);
  });
  });
}
