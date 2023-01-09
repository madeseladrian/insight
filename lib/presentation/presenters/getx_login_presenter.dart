import 'package:get/get.dart';
import 'package:insight/domain/errors/domain_error.dart';

import '../../domain/features/features.dart';
import '../../domain/params/params.dart';

import '../../ui/helpers/helpers.dart';

import '../contracts/contracts.dart';
import '../helpers/helpers.dart';
import '../mixins/mixins.dart';

class GetxLoginPresenter extends GetxController 
with FormManager, LoadingManager, NavigationManager, UIErrorManager  {
  final Authentication authentication;
  final Validation validation;

  String? _email;
  String? _password;

  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);

  Stream<UIError?> get emailErrorStream => _emailError.stream;
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  GetxLoginPresenter({
    required this.authentication,
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

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email');
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password');
    _validateForm();
  }

  Future<void> auth() async {
    try {
      mainError = null;
      isLoading = true;
      await authentication.auth(AuthenticationParams(
        email: _email, 
        password: _password
      ));
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

  void support() {
    navigateTo = '/support';
  }
}