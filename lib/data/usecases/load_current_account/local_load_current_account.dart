import '../../../domain/entities/entities.dart';
import '../../../domain/errors/errors.dart';

import '../../contracts/contracts.dart';

class LocalLoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetch('token');
      if (token == null) throw Error();
      return AccountEntity(token: token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  } 
}