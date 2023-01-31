import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:insight/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late InitialPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = InitialPresenterSpy();
    await tester.pumpWidget(
      makePage(path: '/initial', page: () => InitialPage(presenter: presenter))
    );
  }

  testWidgets('1 - Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);
  
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('2 - Should call goToCamera on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.goToCamera()).called(1);
  });

  testWidgets('3 - Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitNavigateTo('any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, 'any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('4 - Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitNavigateTo('');
    await tester.pump();
    expect(Get.currentRoute, '/initial');
  });
}