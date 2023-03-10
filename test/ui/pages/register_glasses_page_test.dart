import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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

  testWidgets('2 - Should upload photos with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);

    final buttonCamera = tester.widget<ButtonRegister>(find.byKey(const Key('camera')));
    expect(buttonCamera.onPressed, isNotNull);

    final buttonGallery = tester.widget<ButtonRegister>(find.byKey(const Key('gallery')));
    expect(buttonGallery.onPressed, isNotNull);
  });

  testWidgets('3 - Should call getCamera on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    final button = find.byKey(const Key('camera'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.getCamera()).called(1);
  });

  testWidgets('4 - Should call getGallery on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    final button = find.byKey(const Key('gallery'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.getGallery()).called(1);
  });

  testWidgets('5 - Should disable button if form is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormError();
    await tester.pump();

    final button = tester.widget<DefaultButton>(find.byKey(const Key('register glasses')));
    expect(button.onPressed, null);
  });

  testWidgets('6 - Should enable button if form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pump();

    final button = tester.widget<DefaultButton>(find.byKey(const Key('register glasses')));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('7 - Should call uploadPhotos on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();

    await tester.pump();
    final button = find.byKey(const Key('register glasses'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.uploadPhotos()).called(1);
  });
}