import 'package:mocktail/mocktail.dart';

import 'package:insight/validation/contracts/contracts.dart';
import 'package:insight/presentation/helpers/helpers.dart';

class FieldValidationSpy extends Mock implements FieldValidation {
  FieldValidationSpy() {
    mockValidation();
    mockFieldName('any_field');
  }

  When mockValidationCall() => when(() => validate(any()));
  void mockValidation() => mockValidationCall().thenReturn(null);
  void mockValidationError(ValidationError error) => mockValidationCall().thenReturn(error);

  void mockFieldName(String fieldName) => when(() => field).thenReturn(fieldName);
}