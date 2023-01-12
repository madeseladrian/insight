import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:insight/ui/helpers/helpers.dart';
import 'package:insight/ui/pages/pages.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {
  final nameErrorController = StreamController<UIError?>();
  final emailErrorController = StreamController<UIError?>();
  final passwordErrorController = StreamController<UIError?>();
    
  SignUpPresenterSpy() {
    when(() => nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
  }

  void emitNameValid() => nameErrorController.add(null);
  void emitNameError(UIError error) => nameErrorController.add(error);
  void emitEmailValid() => emailErrorController.add(null);
  void emitEmailError(UIError error) => emailErrorController.add(error);
  void emitPasswordValid() => passwordErrorController.add(null);
  void emitPasswordError(UIError error) => passwordErrorController.add(error);

  @override
  void dispose() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
  }
}