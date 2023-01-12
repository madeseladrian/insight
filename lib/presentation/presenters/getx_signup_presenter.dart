import 'package:get/get.dart';

import '../../ui/helpers/helpers.dart';

import '../contracts/contracts.dart';

class GetxSignUpPresenter extends GetxController {
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
    validation.validate(field: field, input: formData);
    return null;
  }
  
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name');
  }
}