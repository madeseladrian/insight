import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/domain/params/params.dart';
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
    await sut.auth(params);
    verify(() => httpClient.request(
      url: url,
      method: 'post',
      body: {"username": params.email, "password": params.password}
    ));
  });
}