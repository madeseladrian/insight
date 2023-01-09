import 'package:insight/data/errors/errors.dart';
import 'package:insight/domain/errors/domain_error.dart';

import '../../../domain/params/params.dart';

import '../../contracts/contracts.dart';
import '../../models/models.dart';
import '../../params/params.dart';

class RemoteAuthentication {
  final String url;
  final HttpClient httpClient;

  RemoteAuthentication({required this.url, required this.httpClient});

  Future auth(AuthenticationParams params) async {
    try {
      final body = RemoteAuthenticationParams.fromDomain(params).toJson();
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError {
      throw DomainError.unexpected;
    }
  }
}