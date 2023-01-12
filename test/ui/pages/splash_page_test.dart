import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:insight/ui/pages/pages.dart';

import '../mocks/mocks.dart';

void main() {
  late SplashPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    await tester.pumpWidget(
      makePage(path: '/', page: () => SplashPage(presenter: presenter))
    );
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('1 - Should call loadCurrentAccount on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.checkAccount()).called(1);
  });
}