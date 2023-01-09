import 'dart:convert';
import 'package:http/http.dart';

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
    return response.body.isEmpty ? null : jsonDecode(response.body);
  }
}