import '../../../../presentation/contracts/contracts.dart';
import '../../../../validation/contracts/contracts.dart';

import '../../../builders/builders.dart';
import '../../../composites/composites.dart';

Validation makeSignUpValidation() {
  return ValidationComposite(makeSignUpValidations());
}

List<FieldValidation> makeSignUpValidations() {
  return [
    ...ValidationBuilder.field('name').requiredField().min(3).build(),
    ...ValidationBuilder.field('email').requiredField().email().build(),
    ...ValidationBuilder.field('password').requiredField().min(3).build(),
    ...ValidationBuilder.field('passwordConfirmation').requiredField().sameAs('password').build(),
  ];
}