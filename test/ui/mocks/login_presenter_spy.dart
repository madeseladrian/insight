import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:insight/ui/helpers/helpers.dart';
import 'package:insight/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {
  final emailErrorController = StreamController<UIError?>();

  LoginPresenterSpy() {
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
  }

  void emitEmailError(UIError error) => emailErrorController.add(error);
  void emitEmailValid() => emailErrorController.add(null);
  
  @override
  void dispose() {
    emailErrorController.close();
  }
}