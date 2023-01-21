import 'dart:convert';

import 'package:http/http.dart';

import '../../data/contracts/http/http.dart';
import '../../data/errors/errors.dart';

class HttpAdapter implements HttpClient {
  final Client client;
  
  HttpAdapter({required this.client});

  @override
  Future request({required String url, required String method, Map? body, Map? headers}) async {
    final routeLogin = url.split('/').contains('login');
    final defaultHeaders = headers?.cast<String, String>() ?? {}..addAll({
      'content-type': routeLogin 
        ? 'application/x-www-form-urlencoded'
        : 'application/json',
      'accept': 'application/json'
    });
    final defaultBody = body != null 
      ? (routeLogin ? body : jsonEncode(body)) 
      : null;
    var response = Response('', 500);
    try {
      if (method == 'post') {

        response = await client.post(
          Uri.parse(url), 
          headers: defaultHeaders,
          body: defaultBody,
        );
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200: return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204: return null;
      case 400: throw HttpError.badRequest;
      case 401: throw HttpError.unauthorized;
      case 403: throw HttpError.forbidden;
      case 404: throw HttpError.notFound;
      default: throw HttpError.serverError;
    }
  }
}