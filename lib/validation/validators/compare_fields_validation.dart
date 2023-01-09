import 'package:equatable/equatable.dart';

import '../../presentation/helpers/helpers.dart';
import '../contracts/contracts.dart';

class CompareFieldsValidation extends Equatable implements FieldValidation {
  @override
  final String field;
  final String fieldToCompare;

  @override
  List get props => [field, fieldToCompare];

  const CompareFieldsValidation({ required this.field, required this.fieldToCompare});

  @override
  ValidationError? validate(Map input) {
    return input[field] != null && input[fieldToCompare] != null
    && input[field] != input[fieldToCompare]
      ? ValidationError.invalidField : null;
  }
}