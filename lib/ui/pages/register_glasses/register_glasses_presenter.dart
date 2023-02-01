abstract class RegisterGlassesPresenter {
  Stream<dynamic> get imageStream;

  void getCamera();
  void getGallery();
  Future<void> uploadPhotos();

  void dispose();
}