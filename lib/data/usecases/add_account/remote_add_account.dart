import '../../../domain/params/params.dart';

import '../../contracts/contracts.dart';
import '../../params/params.dart';

class RemoteAddAccount {
  final String url;
  final HttpClient httpClient;

  RemoteAddAccount({required this.url, required this.httpClient});

  Future add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    await httpClient.request(url: url, method: 'post', body: body);
  }
}