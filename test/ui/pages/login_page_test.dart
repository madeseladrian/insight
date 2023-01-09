import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:insight/ui/pages/pages.dart';

import '../mocks/mocks.dart';

void main() {
  late LoginPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    await tester.pumpWidget(
      makePage(path: '/login', page: () => LoginPage(presenter: presenter))
    );
  }

  testWidgets('1,2,3 - Should load with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);
    final emailTextChildren = find.descendant(
      of: find.bySemanticsLabel('Email'), 
      matching: find.byType(Text)
    );
    expect(
      emailTextChildren, 
      findsOneWidget,
      reason: 'When a TextFormField has only one text child, means it has no errors, ' 
      'since one of the childs is always the label text'   
    );

    final passwordTextChildren = find.descendant(
      of: find.bySemanticsLabel('Senha'),
      matching: find.byType(Text),
    );
    expect(
      passwordTextChildren, 
      findsOneWidget,  
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}