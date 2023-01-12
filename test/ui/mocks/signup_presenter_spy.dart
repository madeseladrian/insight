import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:insight/ui/helpers/helpers.dart';
import 'package:insight/ui/pages/pages.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {
  final nameErrorController = StreamController<UIError?>();
  final emailErrorController = StreamController<UIError?>();

  SignUpPresenterSpy() {
    when(() => nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => emailErrorStream).thenAnswer((_) => emailErrorController.stream);
  }

  @override
  void dispose() {
    nameErrorController.close();
    emailErrorController.close();
  }
}