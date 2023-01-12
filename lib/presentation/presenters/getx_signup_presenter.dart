import 'package:get/get.dart';
import 'package:insight/domain/features/add_account.dart';

import '../../domain/params/params.dart';
import '../../ui/helpers/helpers.dart';

import '../contracts/contracts.dart';
import '../helpers/helpers.dart';
import '../mixins/mixins.dart';

class GetxSignUpPresenter extends GetxController 
with LoadingManager, FormManager, UIErrorManager {
  final AddAccount addAccount;
  final Validation validation;

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;

  final _nameError = Rx<UIError?>(null);
  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _passwordConfirmationError = Rx<UIError?>(null);

  Stream<UIError?> get nameErrorStream => _nameError.stream;
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;
  Stream<UIError?> get passwordConfirmationErrorStream => _passwordConfirmationError.stream;

  GetxSignUpPresenter({
    required this.addAccount,
    required this.validation
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
  
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name');
    _validateForm();
  }

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email');
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password',);
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(field: 'passwordConfirmation');
    _validateForm();
  }

  Future<void> signUp() async {
    mainError = null;
    isLoading = true;
    await addAccount.add(params: AddAccountParams(
        name: _name,
        email: _email,
        password: _password,
        passwordConfirmation: _passwordConfirmation
      )
    );  
  }
}