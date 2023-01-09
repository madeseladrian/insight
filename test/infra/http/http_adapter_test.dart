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

    test('10 - Should return UnauthorizedError if post returns 401', () async {
      client.mockPost(401); 
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.unauthorized));
    });

    test('11 - Should return ForbiddenError if post returns 403', () async {
      client.mockPost(403); 
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.forbidden));
    });

    test('12 - Should return NotFoundError if post returns 404', () async {
      client.mockPost(404); 
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.notFound));
    });

    test('13 - Should return ServerError if post returns 500', () async {
      client.mockPost(500); 
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.serverError));
    });

    // Is an error different from the others
    test('14 - Should return ServerError if post throws with 422', () async {
      client.mockPost(422); 
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.serverError));
    });

    test('15 - Should return ServerError if post throws', () async {
      client.mockPostError(); 
      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.serverError));
    });
  });  

  group('shared', () {
    test('* - Should throw ServerError if invalid method is provided', () {
      final future = sut.request(url: url, method: 'invalid_method');
      expect(() => future, throwsA(HttpError.serverError));
    });
  });
}