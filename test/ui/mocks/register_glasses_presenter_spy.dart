import 'dart:async';
import 'dart:io';

import 'package:mocktail/mocktail.dart';

import 'package:insight/ui/pages/pages.dart';

import '../../domain/mocks/entity_factory.dart';

class RegisterGlassesPresenterSpy extends Mock implements RegisterGlassesPresenter {
  final isFormValidController = StreamController<bool>();
  final imageController = StreamController<File>();

  RegisterGlassesPresenterSpy() {
    when(() => uploadPhotos()).thenAnswer((_) async => EntityFactory.makeImage());
    when(() => isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(() => imageStream).thenAnswer((_) => imageController.stream);
  } 

  void emitFormError() => isFormValidController.add(false);
  void emitFormValid() => isFormValidController.add(true);
  void emitImage(dynamic image) => imageController.add(image);

  @override
  void dispose() {
    isFormValidController.close();
    imageController.close();
  }
}