import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testing_flutter/main.dart';

void main() {
  testWidgets('Counter increments Counter widget', (WidgetTester tester) async {
    //setup
    await tester.pumpWidget(const MyApp());
    //do
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    //test
    // expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
