import '../../../domain/entities/entities.dart';
import '../../contracts/contracts.dart';

class LocalLoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  Future<AccountEntity> load() async {
    final token = await fetchSecureCacheStorage.fetch('token');
    return AccountEntity(token: token);
  } 
}