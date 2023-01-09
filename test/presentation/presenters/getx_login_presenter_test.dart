import 'package:faker/faker.dart';
import 'package:insight/domain/errors/errors.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/domain/entities/entities.dart';
import 'package:insight/domain/params/params.dart';

import 'package:insight/presentation/helpers/helpers.dart';
import 'package:insight/presentation/presenters/presenters.dart';

import 'package:insight/ui/helpers/helpers.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';
 
void main() {
  late String email;
  late String password;
  late AccountEntity accountEntity;
  late AuthenticationSpy authentication;
  late ValidationSpy validation;
  late GetxLoginPresenter sut;

  setUp(() {
    email = faker.internet.email();
    password = faker.internet.password();
    accountEntity = EntityFactory.makeAccount();
    authentication = AuthenticationSpy();
    authentication.mockAuthentication(accountEntity);
    validation = ValidationSpy();
    sut = GetxLoginPresenter(
      authentication: authentication,
      validation: validation
    );
  });

  setUpAll(() {
    registerFallbackValue(EntityFactory.makeAccount());
    registerFallbackValue(ParamsFactory.makeAuthentication());
  });

  test('1 - Should call Validation with correct email', () async {
    final formData = {'email': email, 'password': null};
    sut.validateEmail(email);
    verify(() => validation.validate(field: 'email', input: formData)).called(1);
  });

  test('2,3,4 - Should emailErrorStream returns invalidFieldError if email is empty', () async {
    validation.mockValidationError(value: ValidationError.invalidField);

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('2,3,4 - Should emailErrorStream returns requiredFieldError if email is null', () async {
    validation.mockValidationError(value: ValidationError.requiredField);

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('5 - Should emailErrorStream returns null if validation email succeeds', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('6 - Should call Validation with correct password', () async {
    final formData = {'email': null, 'password': password};
    sut.validatePassword(password);
    verify(() => validation.validate(field: 'password', input: formData)).called(1);
  });

  test('7,8,9,10 - Should passwordErrorStream returns invalidFieldError if password is empty', () async {
    validation.mockValidationError(value: ValidationError.requiredField);
   
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('7,8,9,10 - Should passwordErrorStream returns null if validation password succeeds', () async {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('11 - Should disable form button if any field is invalid', () async {
    validation.mockValidationError(value: ValidationError.requiredField);
    
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('11 - Should enable form button if all fields are valid', () async {
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('12 - Should call Authentication with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);
    
    await sut.auth();

    verify(() => authentication.auth(
      AuthenticationParams(email: email, password: password)
    )).called(1);
  });

  test('13 - Should emit correct events on Authentication success', () async {
    expectLater(sut.isLoadingStream, emits(true));
    expectLater(sut.mainErrorStream, emits(null));

    await sut.auth();
  });

  test('14 - Should emit correct events on InvalidCredentialsError', () async {
    authentication.mockAuthenticationError(DomainError.invalidCredentials);
    
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.invalidCredentials]));

    await sut.auth();
  });

  test('15 - Should emit correct events on UnexpectedError', () async {
    authentication.mockAuthenticationError(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));

    await sut.auth();
  });

  test('18 - Should change page on success authentication', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/initial')));

    await sut.auth();
  });

  test('19 - Should change to support page', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/support')));

    sut.support();
  });

  test('20 - Should change to support page multiple times', () async {
    expectLater(sut.navigateToStream, emitsInOrder(['/support', '/support']));
    
    sut.support();
    sut.support();
  });
}