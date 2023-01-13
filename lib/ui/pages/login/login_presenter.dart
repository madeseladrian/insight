import '../../helpers/helpers.dart';

abstract class LoginPresenter {
  Stream<UIError?> get emailErrorStream;
  Stream<UIError?> get passwordErrorStream;
  Stream<UIError?> get mainErrorStream;
  Stream<String?> get navigateToStream;
  Stream<bool> get isFormValidStream;

  void validateEmail(String email);
  void validatePassword(String password);
  Future<void> auth();
  void goToSignUp();
  void support();
  void recoverPassword();
  void dispose();
}