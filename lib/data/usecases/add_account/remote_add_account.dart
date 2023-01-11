import '../../../domain/entities/entities.dart';
import '../../../domain/errors/errors.dart';
import '../../../domain/features/features.dart';
import '../../../domain/params/params.dart';

import '../../contracts/contracts.dart';
import '../../models/models.dart';
import '../../params/params.dart';

class RemoteAddAccount implements AddAccount {
  final String url;
  final HttpClient httpClient;

  RemoteAddAccount({required this.url, required this.httpClient});

  @override
  Future<AccountEntity> add({required AddAccountParams params}) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}