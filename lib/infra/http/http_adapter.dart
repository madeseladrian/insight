import 'dart:convert';

import 'package:http/http.dart';

import '../../data/errors/errors.dart';

class HttpAdapter {
  final Client client;
  
  HttpAdapter({required this.client});

  Future request({required String url, required String method, Map? body, Map? headers
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}..addAll({
      "content-type": "application/x-www-form-urlencoded"
    });
    final encoding = Encoding.getByName('utf-8');
    final response = await client.post(
      Uri.parse(url), 
      headers: defaultHeaders,
      encoding: encoding,
      body: body
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200: return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204: return null;
      case 400: throw HttpError.badRequest;
      case 401: throw HttpError.unauthorized;
      case 403: throw HttpError.forbidden;
    }
  }
}