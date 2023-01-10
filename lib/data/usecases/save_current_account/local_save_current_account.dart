import '../../../domain/entities/entities.dart';
import '../../../domain/features/features.dart';

import '../../contracts/contracts.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  @override
  Future<void> save({required AccountEntity accountEntity}) async {
    await saveSecureCacheStorage.save(
      key: 'token',
      value: accountEntity.token
    );
  }
}