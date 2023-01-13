import '../../../domain/features/features.dart';
import '../../../data/usecases/usecases.dart';
import '../cache/cache.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return LocalLoadCurrentAccount(
    fetchSecureCacheStorage: makeSecureStorageAdapter()
  );
}