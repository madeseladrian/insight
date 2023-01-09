import '../../../domain/params/params.dart';

import '../../contracts/contracts.dart';
import '../../models/models.dart';
import '../../params/params.dart';

class RemoteAuthentication {
  final String url;
  final HttpClient httpClient;

  RemoteAuthentication({required this.url, required this.httpClient});

  Future auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
    return RemoteAccountModel.fromJson(httpResponse).toEntity();
  }
}