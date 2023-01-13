import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:insight/ui/helpers/helpers.dart';
import 'package:insight/ui/pages/pages.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {
  final nameErrorController = StreamController<UIError?>();
  final emailErrorController = StreamController<UIError?>();
  final passwordErrorController = StreamController<UIError?>();
  final passwordConfirmationErrorController = StreamController<UIError?>();
  final mainErrorController = StreamController<UIError?>();
  final isFormValidController = StreamController<bool>();
  final navigateToController = StreamController<String?>();

  SignUpPresenterSpy() {
    when(() => signUp()).thenAnswer((_) async => _);
    when(() => nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => passwordConfirmationErrorStream).thenAnswer((_) => passwordConfirmationErrorController.stream);
    when(() => mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);
  }

  void emitNameValid() => nameErrorController.add(null);
  void emitNameError(UIError error) => nameErrorController.add(error);
  void emitEmailValid() => emailErrorController.add(null);
  void emitEmailError(UIError error) => emailErrorController.add(error);
  void emitPasswordValid() => passwordErrorController.add(null);
  void emitPasswordError(UIError error) => passwordErrorController.add(error);
  void emitPasswordConfirmationValid() => passwordConfirmationErrorController.add(null);
  void emitPasswordConfirmationError(UIError error) => passwordConfirmationErrorController.add(error);
  void emitMainError(UIError error) => mainErrorController.add(error);
  void emitFormValid() => isFormValidController.add(true);
  void emitFormError() => isFormValidController.add(false);
  void emitNavigateTo(String route) => navigateToController.add(route);

  @override
  void dispose() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
    mainErrorController.close();
    isFormValidController.close();
    navigateToController.close();
  }
}