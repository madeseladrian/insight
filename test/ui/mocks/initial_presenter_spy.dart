import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:insight/ui/pages/pages.dart';

class InitialPresenterSpy extends Mock implements InitialPresenter {
  final navigateToController = StreamController<String?>();

  InitialPresenterSpy() {
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);
  } 

  void emitNavigateTo(String route) => navigateToController.add(route);

  @override
  void dispose() {
    navigateToController.close();
  }
}