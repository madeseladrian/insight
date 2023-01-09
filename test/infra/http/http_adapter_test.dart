import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/infra/http/http.dart';

import '../mocks/mocks.dart';

void main() {
  late String url;
  late ClientSpy client;
  late HttpAdapter sut;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client: client);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });

  group('post', () {
    test('1,2,3,4 - Should call post with correct values', () async {
      sut.request(url: url, method: 'post', body: {"any_key":"any_value"});
      verify(() => client.post(
        Uri.parse(url),
        headers: {"content-type": "application/x-www-form-urlencoded"},
        encoding: Encoding.getByName('utf-8'),
        body: {"any_key":"any_value"}
      ));
    });

    test('5 - Should return data if post returns 200', () async { 
      final response = await sut.request(url: url, method: 'post');
      expect(response, {"any_key":"any_value"});
    });

    test('6 - Should return data if post returns 200 without data', () async { 
      client.mockPost(200, body: '');
      final response = await sut.request(url: url, method: 'post');
      expect(response, null);
    });
  });  
}