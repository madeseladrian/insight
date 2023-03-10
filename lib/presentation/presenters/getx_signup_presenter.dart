import 'package:get/get.dart';

import '../../domain/errors/errors.dart';
import '../../domain/features/features.dart';
import '../../domain/params/params.dart';

import '../../ui/pages/pages.dart';
import '../../ui/helpers/helpers.dart';

import '../contracts/contracts.dart';
import '../helpers/helpers.dart';
import '../mixins/mixins.dart';

class GetxSignUpPresenter extends GetxController 
with LoadingManager, FormManager, NavigationManager, UIErrorManager 
implements SignUpPresenter {
  final AddAccount addAccount;
  final Authentication authentication;
  final Validation validation;
  final SaveCurrentAccount saveCurrentAccount;

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;

  final _nameError = Rx<UIError?>(null);
  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _passwordConfirmationError = Rx<UIError?>(null);

  @override
  Stream<UIError?> get nameErrorStream => _nameError.stream;
  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<UIError?> get passwordConfirmationErrorStream => _passwordConfirmationError.stream;

  GetxSignUpPresenter({
    required this.addAccount,
    required this.authentication,
    required this.validation,
    required this.saveCurrentAccount
  });

  UIError? _validateField({required String field}) {
    final formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation
    };
    final error = validation.validate(field: field, input: formData);
    switch(error) {
      case ValidationError.invalidField: return UIError.invalidField;
      case ValidationError.requiredField: return UIError.requiredField;
      default: return null;
    }
  }

  void _validateForm() {
    isFormValid = _emailError.value == null
      && _nameError.value == null
      && _passwordError.value == null
      && _passwordConfirmationError.value == null
      && _name != null
      && _email != null
      && _password != null
      && _passwordConfirmation != null;
  }
  
  @override
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name');
    _validateForm();
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
    _passwordError.value = _validateField(field: 'password',);
    _validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(field: 'passwordConfirmation');
    _validateForm();
  }

  @override
  Future<void> signUp() async {
    try {
      mainError = null;
      isLoading = true;
      await addAccount.add(params: AddAccountParams(
          name: _name,
          email: _email,
          password: _password,
          passwordConfirmation: _passwordConfirmation
        )
      );
      final accountEntity = await authentication.auth(params: AuthenticationParams(
        email: _email, 
        password: _password
      ));
      await saveCurrentAccount.save(accountEntity: accountEntity);
      navigateTo = '/initial';
    } on DomainError catch (error) {
      isLoading = false;
      switch (error) {
        case DomainError.emailInUse: mainError = UIError.emailInUse; break;
        case DomainError.invalidCredentials:
          mainError = UIError.invalidCredentials; break; 
        default: mainError = UIError.unexpected; break;
      }
    } 
  }
  
  @override
  void goToLogin() {
    navigateTo = '/login';
  }
  
  @override
  void support() {
    navigateTo = '/support';
  }
}