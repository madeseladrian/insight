import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/domain/errors/errors.dart';
import 'package:insight/domain/params/params.dart';

import 'package:insight/data/errors/errors.dart';
import 'package:insight/data/usecases/usecases.dart';

import '../../mocks/mocks.dart';

void main() {
  late String url;
  late HttpClientSpy httpClient;
  late RemoteAddAccount sut;
  late Map apiResult;
  late AddAccountParams params;

  setUp(() {
    params = AddAccountParams(
      name: faker.person.name(),
      email: faker.internet.email(),
      password: faker.internet.password(),
      passwordConfirmation: faker.internet.password()
    );
    apiResult = {"access_token": faker.guid.guid()};
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    httpClient.mockRequest(apiResult);
    sut = RemoteAddAccount(url: url, httpClient: httpClient);
  });
 
  test('1,2 - Should call HttpClient with correct values', () async {
    await sut.add(params: params);
    verify(() => httpClient.request(
      url: url,
      method: 'post',
      body: {
        "name": params.name,
        "email": params.email, 
        "password": params.password,
        "passwordConfirmation": params.passwordConfirmation                            
      }
    ));
  });

  test('3,4 - Should return an Account if HttpClient returns 200', () async {
    final account = await sut.add(params: params);
    expect(account.token, apiResult['access_token']);
  });

  test('5 - Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);
    final future = sut.add(params: params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('6 - Should throw InvalidCredentialsError if HttpClient returns 403', () async {
    httpClient.mockRequestError(HttpError.forbidden);
    final future = sut.add(params: params);
    expect(future, throwsA(DomainError.emailInUse));
  });

  test('7 - Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);
    final future = sut.add(params: params);
    expect(future, throwsA(DomainError.unexpected));
  });
}