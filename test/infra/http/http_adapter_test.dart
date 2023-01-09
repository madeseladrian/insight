import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/data/errors/errors.dart';
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
    
    test('7 - Should return null if post returns 204 with data', () async {
      client.mockPost(204); 
      final response = await sut.request(url: url, method: 'post');
      expect(response, null);
    });

    // Error tests body is not necessary, because it is the same as without body
    test('8 - Should return BadRequestError if post returns 400 with body', () async {
      client.mockPost(400, body: ''); 
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.badRequest));
    });

    test('9 - Should return BadRequestError if post returns 400', () async {
      client.mockPost(400); 
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.badRequest));
    });
  });  
}