import 'dart:io';

abstract class RegisterGlassesPresenter {
  Stream<bool> get isFormValidStream;
  Stream<File?> get imageStream;

  void getCamera();
  void getGallery();
  Future<void> uploadPhotos();

  void dispose();
}