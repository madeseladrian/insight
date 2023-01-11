import '../../../domain/entities/entities.dart';
import '../../../domain/errors/errors.dart';
import '../../../domain/features/features.dart';
import '../../../domain/params/params.dart';

import '../../contracts/contracts.dart';
import '../../errors/errors.dart';
import '../../models/models.dart';
import '../../params/params.dart';

class RemoteAuthentication implements Authentication {
  final String url;
  final HttpClient httpClient;

  RemoteAuthentication({required this.url, required this.httpClient});

  @override
  Future<AccountEntity> auth({required AuthenticationParams params}) async {
    try {
      final body = RemoteAuthenticationParams.fromDomain(params).toJson();
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized 
        ? DomainError.invalidCredentials
        : DomainError.unexpected;
    }
  }
}