import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/domain/entities/entities.dart';
import 'package:insight/domain/errors/errors.dart';
import 'package:insight/domain/params/params.dart';

import 'package:insight/presentation/helpers/helpers.dart';
import 'package:insight/presentation/presenters/presenters.dart';

import 'package:insight/ui/helpers/helpers.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {
  late GetxSignUpPresenter sut;
  late AddAccountSpy addAccount;
  late ValidationSpy validation;
  late String name;
  late String email;
  late String password;
  late String passwordConfirmation;
  late AccountEntity account;

  setUp(() {
    name = faker.person.name();
    email = faker.internet.email();
    password = faker.internet.password();
    passwordConfirmation = faker.internet.password();
    account = EntityFactory.makeAccount();
    addAccount = AddAccountSpy();
    addAccount.mockAddAccount(account);
    validation = ValidationSpy();
    sut = GetxSignUpPresenter(
      addAccount: addAccount,
      validation: validation
    );
  });

  setUpAll(() {
    registerFallbackValue(ParamsFactory.makeAddAccount());
    registerFallbackValue(EntityFactory.makeAccount());
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

  test('10 - Should emailErrorStream returns null if validation email succeeds', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('11 - Should call Validation with correct password', () async {
    final formData = {'name': null, 'email': null, 'password': password, 'passwordConfirmation': null};

    sut.validatePassword(password);
    
    verify(() => validation.validate(field: 'password', input: formData)).called(1);
  });

  test('12,13,14 - Should passwordErrorStream returns invalidFieldError if password is empty', () async {
    validation.mockValidationError(value: ValidationError.invalidField);
   
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('12,13,14 - Should passwordErrorStream returns requiredFieldError if password is null', () async {
    validation.mockValidationError(value: ValidationError.requiredField);
   
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('15 - Should passwordErrorStream returns null if validation password succeeds', () async {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('16 - Should call Validation with correct passwordConfirmation', () async {
    final formData = {'name': null, 'email': null, 'password': null, 'passwordConfirmation': passwordConfirmation};
    
    sut.validatePasswordConfirmation(passwordConfirmation);
    
    verify(() => validation.validate(
      field: 'passwordConfirmation', 
      input: formData 
    )).called(1);
  });

  test('17,18,19 - Should passwordConfirmationErrorStream returns invalidFieldError if passwordConfirmation is empty', () async {
    validation.mockValidationError(value: ValidationError.invalidField);
   
    sut.passwordConfirmationErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('17,18,19 - Should passwordConfirmationErrorStream returns requiredFieldError if passwordConfirmation is null', () async {
    validation.mockValidationError(value: ValidationError.requiredField);
   
    sut.passwordConfirmationErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('20 - Should passwordConfirmationErrorStream returns null if validation passwordconfirmation succeeds', () async {
    sut.passwordConfirmationErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('21 - Should call isFormValidStream disable form button if any field is invalid', () async {
    validation.mockValidationError(field: 'email', value: ValidationError.requiredField);
    
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('22,23 - Should call isFormValidStream enable form button if all fields are valid', () async {
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('24 - Should call AddAccount with correct values', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    
    await sut.signUp();

    verify(() => addAccount.add(params: AddAccountParams(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation
    ))).called(1);
  });

  test('25 - Should emit correct events on AddAccount success', () async {  
    expectLater(sut.isLoadingStream, emits(true));
    expectLater(sut.mainErrorStream, emits(null));
    
    await sut.signUp();
  });

  test('26,27 - Should emit correct events on UnexpectedError', () async {
    addAccount.mockAddAccountError(DomainError.unexpected);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));

    await sut.signUp();
  });
} 