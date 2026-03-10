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
  });
}
