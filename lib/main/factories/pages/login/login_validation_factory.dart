import '../../../../presentation/contracts/contracts.dart';
import '../../../../validation/contracts/contracts.dart';

import '../../../builders/builders.dart';
import '../../../composites/composites.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').requiredField().email().build(),
    ...ValidationBuilder.field('password').requiredField().build(),
  ];
}