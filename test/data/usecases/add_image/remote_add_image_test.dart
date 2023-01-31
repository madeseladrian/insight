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
    await sut.addImage(image: image);
    verify(() => httpClient.request(
      url: url,
      method: 'post',
      body: {"image": image}
    ));
  });

  test('4 - Should return an ImageEntity if HttpClient returns 200', () async {
    final accountEntity = await sut.addImage(image: image);
    expect(accountEntity.glassesId, apiResult['glasses_id']);
    expect(accountEntity.urlImage, apiResult['url_image']);
  });

  test('5 - Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);
    final future = sut.addImage(image: image);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('6 - Should throw InvalidCredentialsError if HttpClient returns 401', () async {
    httpClient.mockRequestError(HttpError.unauthorized);
    final future = sut.addImage(image: image); 
    expect(future, throwsA(DomainError.invalidCredentials));
  });
}