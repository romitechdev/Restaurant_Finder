import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/widgets/error_widget.dart';

void main() {
  testWidgets('ErrorMessageWidget shows message', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ErrorMessageWidget(message: 'Terjadi kesalahan'),
        ),
      ),
    );

    expect(find.text('Terjadi kesalahan'), findsOneWidget);
  });
}
