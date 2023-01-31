import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:insight/ui/pages/pages.dart';

class RegisterGlassesPresenterSpy extends Mock implements RegisterGlassesPresenter {
  final imageController = StreamController<dynamic>();

  RegisterGlassesPresenterSpy() {
    when(() => uploadPhotos()).thenAnswer((_) async => _);
    when(() => imageStream).thenAnswer((_) => imageController.stream);
  } 

  void emitEmailError(dynamic image) => imageController.add(image);

  @override
  void dispose() {
    imageController.close();
  }
}