import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/presentation/presenters/presenters.dart';

import '../mocks/mocks.dart';

void main() {
  late GetxSignUpPresenter sut;
  late ValidationSpy validation;
  late String name;

  setUp(() {
    name = faker.person.name();
    validation = ValidationSpy();
    sut = GetxSignUpPresenter(
      validation: validation
    );
  });

  test('1 - Should call Validation with correct name', () async {
    final formData = {'name': name, 'email': null, 'password': null, 'passwordConfirmation': null};
    
    sut.validateName(name);
    
    verify(() => validation.validate(field: 'name', input: formData)).called(1);
  });
} 