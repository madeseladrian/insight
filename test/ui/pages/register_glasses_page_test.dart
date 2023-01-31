import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:insight/ui/components/components.dart';
import 'package:insight/ui/pages/pages.dart';

import '../mocks/mocks.dart';

void main() {
  late RegisterGlassesPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = RegisterGlassesPresenterSpy();
    await tester.pumpWidget(
      makePage(path: '/register_glasses', page: () => RegisterGlassesPage(presenter: presenter))
    );
  }

  testWidgets('1 - Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);

    final button = tester.widget<DefaultButton>(find.byKey(const Key('register glasses')));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}