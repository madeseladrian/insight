import 'package:faker/faker.dart';
import 'package:insight/presentation/helpers/helpers.dart';
import 'package:insight/ui/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/presentation/presenters/presenters.dart';

import '../mocks/mocks.dart';

void main() {
  late GetxSignUpPresenter sut;
  late ValidationSpy validation;
  late String name;
  late String email;

  setUp(() {
    name = faker.person.name();
    email = faker.internet.email();
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

  test('2,3,4 - Should call nameErrorStream returns invalidFieldError if name is empty', () async {
    validation.mockValidationError(value: ValidationError.invalidField);
   
    sut.nameErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('2,3,4 - Should call nameErrorStream returns requiredFieldError if name is null', () async {
    validation.mockValidationError(value: ValidationError.requiredField);
   
    sut.nameErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('5 - Should call nameErrorStream returns null if validation name succeeds', () async {
    sut.nameErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validateName(name);
    sut.validateName(name);
  });

  test('6 - Should call Validation with correct email', () async {
    final formData = {'name': null, 'email': email, 'password': null, 'passwordConfirmation': null};

    sut.validateEmail(email);
    
    verify(() => validation.validate(field: 'email', input: formData)).called(1);
  });

  test('7,8,9 - Should emailErrorStream returns invalidFieldError if email is empty', () async {
    validation.mockValidationError(value: ValidationError.invalidField);
   
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('7,8,9 - Should emailErrorStream returns requiredFieldError if email is null', () async {
    validation.mockValidationError(value: ValidationError.requiredField);
   
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
} 