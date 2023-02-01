import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart' ;

import '../../data/contracts/http/http.dart';
import '../../data/errors/errors.dart';
import '../../domain/features/features.dart';

class HttpAdapter implements HttpClient {
  final Client client;
  final LoadCurrentAccount loadCurrentAccount;
  
  HttpAdapter({required this.client, required this.loadCurrentAccount});

  @override
  Future request({required String url, required String method, Map? body, Map? headers}) async {
    final routeLogin = url.split('/').contains('login');
    final routeImage = url.split('/').contains('image');

    final defaultHeaders = headers?.cast<String, String>() ?? {}..addAll({
      'content-type': routeLogin 
        ? 'application/x-www-form-urlencoded'
        : 'application/json',
      'accept': 'application/json'
    });

    final defaultBody = body != null 
      ? (routeLogin || routeImage ? body : jsonEncode(body)) 
      : null;
    var response = Response('', 500);
    try {
      if (method == 'post') {
        if (routeImage) {
          var request = http.MultipartRequest('POST', Uri.parse(url));
          final httpImage = await http.MultipartFile.fromPath(
            'image', 
            body!['image'].path,
            contentType: MediaType('image', 'jpeg')
          );
          final account = await loadCurrentAccount.load();
          request.headers.addAll({"Authorization": "Bearer ${account.token}"});
          request.files.add(httpImage);
          final responseMultipart = await request.send();
          final bodyMultipart = await http.Response.fromStream(responseMultipart);
          response = Response(
            bodyMultipart.body,
            responseMultipart.statusCode
          );
        } else {
          response = await client.post(
            Uri.parse(url), 
            headers: defaultHeaders,
            body: defaultBody,
          );
        }
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