import 'package:get/get.dart';

import '../../ui/helpers/helpers.dart';

import '../contracts/contracts.dart';
import '../helpers/helpers.dart';
import '../mixins/mixins.dart';

class GetxSignUpPresenter extends GetxController 
with FormManager {
  final Validation validation;

  String? _name;

  final _nameError = Rx<UIError?>(null);

  Stream<UIError?> get nameErrorStream => _nameError.stream;

  GetxSignUpPresenter({
    required this.validation
  });

  UIError? _validateField({required String field}) {
    final formData = {
      'name': _name,
      'email': null,
      'password': null,
      'passwordConfirmation': null
    };
    final error = validation.validate(field: field, input: formData);
    switch(error) {
      case ValidationError.invalidField: return UIError.invalidField;
      case ValidationError.requiredField: return UIError.requiredField;
      default: return null;
    }
  }

  void _validateForm() {
    isFormValid = _nameError.value == null
      && _name != null;
  }
  
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name');
    _validateForm();
  }
}