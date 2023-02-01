import 'dart:io';

import '../../../domain/entities/entities.dart';

abstract class RegisterGlassesPresenter {
  Stream<bool> get isFormValidStream;
  Stream<File?> get imageStream;

  void getCamera();
  void getGallery();
  Future<ImageEntity> uploadPhotos();

  void dispose();
}