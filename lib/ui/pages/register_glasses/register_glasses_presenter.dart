abstract class RegisterGlassesPresenter {
  Stream<dynamic> get imageStream;

  void getCamera();
  void getGalery();
  Future<void> uploadPhotos();

  void dispose();
}