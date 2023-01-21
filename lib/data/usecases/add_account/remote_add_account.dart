import '../../../domain/errors/errors.dart';
import '../../../domain/features/features.dart';
import '../../../domain/params/params.dart';

import '../../contracts/contracts.dart';
import '../../errors/errors.dart';
import '../../params/params.dart';

class RemoteAddAccount implements AddAccount {
  final String url;
  final HttpClient httpClient;

  RemoteAddAccount({required this.url, required this.httpClient});

  @override
  Future<void> add({required AddAccountParams params}) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    try {
      await httpClient.request(url: url, method: 'post', body: body);
    } catch (error) {
      throw error == HttpError.forbidden
        ? DomainError.emailInUse
        : DomainError.unexpected;
    }
  }
}