import 'package:insight/data/params/remote_authentication_params.dart';

import '../../../domain/params/params.dart';

import '../../contracts/contracts.dart';

class RemoteAuthentication {
  final String url;
  final HttpClient httpClient;

  RemoteAuthentication({required this.url, required this.httpClient});

  Future auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    await httpClient.request(url: url, method: 'post', body: body);
  }
}