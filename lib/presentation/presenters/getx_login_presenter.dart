import 'package:get/get.dart';

import '../../domain/errors/domain_error.dart';
import '../../domain/features/features.dart';
import '../../domain/params/params.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/login/login.dart';

import '../contracts/contracts.dart';
import '../helpers/helpers.dart';
import '../mixins/mixins.dart';

class GetxLoginPresenter extends GetxController 
with FormManager, LoadingManager, NavigationManager, UIErrorManager 
implements LoginPresenter {
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;
  final Validation validation;

  String? _email;
  String? _password;

  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  GetxLoginPresenter({
    required this.authentication,
    required this.saveCurrentAccount,
    required this.validation
  });

  UIError? _validateField({required String field}) {
    final formData = {
      'email': _email,
      'password': _password
    };
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField: return UIError.invalidField;
      case ValidationError.requiredField: return UIError.requiredField;
      default: return null;
    }
  }
  
  void _validateForm() {
    isFormValid = _emailError.value == null
      && _passwordError.value == null 
      && _email != null
      && _password != null;
  }

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email');
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password');
    _validateForm();
  }

  @override
  Future<void> auth() async {
    try {
      mainError = null;
      isLoading = true;
      final accountEntity = await authentication.auth(params: AuthenticationParams(
        email: _email, 
        password: _password
      ));
      await saveCurrentAccount.save(accountEntity: accountEntity);
      navigateTo = '/initial';
    } on DomainError catch (error) {
      isLoading = false;
      switch (error) {
        case DomainError.invalidCredentials:
          mainError = UIError.invalidCredentials; break;        
        default: mainError = UIError.unexpected;
      }
    }
  }

  @override
  void goToSignUp() {
    navigateTo = '/signup';
  }

  @override
  void support() {
    navigateTo = '/support';
  }

  @override
  void recoverPassword() {
    navigateTo = '/recoverPassword';
  }
}