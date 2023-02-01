import 'dart:io';

import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/domain/errors/errors.dart';

import 'package:insight/data/errors/errors.dart';
import 'package:insight/data/usecases/usecases.dart';

import '../../mocks/mocks.dart';

void main() {
  late String url;
  late File image;
  late Map apiResult;
  late HttpClientSpy httpClient;
  late RemoteAddImage sut;

  setUp(() {
    url = faker.internet.httpUrl();
    image = File('');
    apiResult = {
      "glasses_id": faker.guid.guid(), 
      "url_image": faker.internet.httpUrl()
    };
    httpClient = HttpClientSpy();
    httpClient.mockRequest(apiResult);
    sut = RemoteAddImage(url: url, httpClient: httpClient);
  });

  test('1,2,3 - Should call HttpClient with correct values', () async {
    await sut.add(image: image);
    verify(() => httpClient.request(
      url: url,
      method: 'post',
      body: {"image": image}
    ));
  });

  test('4 - Should return an ImageEntity if HttpClient returns 200', () async {
    final accountEntity = await sut.add(image: image);
    expect(accountEntity.glassesId, apiResult['glasses_id']);
    expect(accountEntity.urlImage, apiResult['url_image']);
  });

  test('5 - Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);
    final future = sut.add(image: image);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('6 - Should throw InvalidCredentialsError if HttpClient returns 401', () async {
    httpClient.mockRequestError(HttpError.unauthorized);
    final future = sut.add(image: image); 
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('7 - Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);
    final future = sut.add(image: image); 
    expect(future, throwsA(DomainError.unexpected));
  });

  test('8 - Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);
    final future = sut.add(image: image); 
    expect(future, throwsA(DomainError.unexpected));
  });

  test('9 - Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    httpClient.mockRequest({'invalid_key': 'invalid_value'});
    final future = sut.add(image: image); 
    expect(future, throwsA(DomainError.unexpected));
  });
}