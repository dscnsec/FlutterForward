import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:testing_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Tap the button", (WidgetTester widgetTester) async {
    //setup
    app.main();
    await widgetTester.pumpAndSettle();
    final Finder buttonFinder = find.byIcon(Icons.add);

    //do
    for (var i = 0; i < 10; i++) {
      await widgetTester.tap(buttonFinder);
      await Future.delayed(const Duration(seconds: 1));
    }
    await widgetTester.pumpAndSettle();

    //test
    expect(find.text("10"), findsOneWidget);
  });
}
