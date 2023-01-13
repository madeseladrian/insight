import '../../../domain/entities/entities.dart';
import '../../../domain/errors/errors.dart';
import '../../../domain/features/features.dart';

import '../../contracts/contracts.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  @override
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