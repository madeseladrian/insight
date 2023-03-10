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
  late AuthenticationParams params;
  late Map apiResult;
  late HttpClientSpy httpClient;
  late RemoteAuthentication sut;

  setUp(() {
    url = faker.internet.httpUrl();
    params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password()
    );
    apiResult = {"access_token": faker.guid.guid()};
    httpClient = HttpClientSpy();
    httpClient.mockRequest(apiResult);
    sut = RemoteAuthentication(url: url, httpClient: httpClient);
  });

  test('1,2,3 - Should call HttpClient with correct values', () async {
    await sut.auth(params: params);
    verify(() => httpClient.request(
      url: url,
      method: 'post',
      body: {"username": params.email, "password": params.password}
    ));
  });

  test('4 - Should return an AccountEntity if HttpClient returns 200', () async {
    final accountEntity = await sut.auth(params: params);
    expect(accountEntity.token, apiResult['access_token']);
  });

  test('5 - Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);
    final future = sut.auth(params: params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('6 - Should throw InvalidCredentialsError if HttpClient returns 401', () async {
    httpClient.mockRequestError(HttpError.unauthorized);
    final future = sut.auth(params: params);
    expect(future, throwsA(DomainError.invalidCredentials));
  });
  
  test('7 - Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);
    final future = sut.auth(params: params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('8 - Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);
    final future = sut.auth(params: params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('9 - Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    httpClient.mockRequest({'invalid_key': 'invalid_value'});
    final future = sut.auth(params: params);
    expect(future, throwsA(DomainError.unexpected));
  });
}