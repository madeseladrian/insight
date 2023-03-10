import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:insight/ui/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';

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
  
  testWidgets('4 - Should call validate with correct email', (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(() => presenter.validateEmail(email));
  });

  testWidgets('5 - Should call validate with correct password', (WidgetTester tester) async {
    await loadPage(tester);

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(() => presenter.validatePassword(password));
  });

  testWidgets('6 - Should present error if email is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailError(UIError.invalidField);
    await tester.pump();

    expect(find.text('Campo inv??lido'), findsOneWidget);
  });

  testWidgets('7 - Should present error if email is empty', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailError(UIError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigat??rio'), findsOneWidget);
  });

  testWidgets('8 - Should present no error if email is valid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitEmailValid();
    await tester.pump();

    expect(
      find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)),
      findsOneWidget
    );
  });
  
  testWidgets('9 - Should present error if password is empty', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPasswordError(UIError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigat??rio'), findsOneWidget);
  });

  testWidgets('10 - Should present no error if password is valid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPasswordValid();
    await tester.pump();

    expect(
      find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)),
      findsOneWidget
    );
  });

  testWidgets('11 - Should enable button if form is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormError();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('12 - Should enable button if form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('13 - Should call authentication on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();
    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.auth()).called(1);
  });

  testWidgets('14 - Should present error message if authentication fails', (WidgetTester tester) async {
    await loadPage(tester);
    
    presenter.emitMainError(UIError.invalidCredentials);
    await tester.pump();

    expect(find.text('Credenciais inv??lidas.'), findsOneWidget);
  });

  testWidgets('15 - Should present error message if authentication throws', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitMainError(UIError.unexpected);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsOneWidget);
  });

  testWidgets('16 - Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitNavigateTo('any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, 'any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('17 - Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitNavigateTo('');
    await tester.pump();
    expect(Get.currentRoute, '/login');
  });

  testWidgets('18 - Should call add account on click text button in header', (WidgetTester tester) async {
    await loadPage(tester);

    await tester.pump();
    final button = find.byKey(const Key('add account header'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.goToSignUp()).called(1);
  });

  testWidgets('19 - Should call recoverPassword on click', (WidgetTester tester) async {
    await loadPage(tester);

    await tester.pump();
    final button = find.byKey(const Key('recover password'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.recoverPassword()).called(1);
  });

  testWidgets('20 - Should call support on click text button in the body', (WidgetTester tester) async {
    await loadPage(tester);

    await tester.pump();
    final button = find.byKey(const Key('support body'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.support()).called(1);
  });
}