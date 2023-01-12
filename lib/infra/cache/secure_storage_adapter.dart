import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/contracts/contracts.dart';

class SecureStorageAdapter implements FetchSecureCacheStorage, SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  SecureStorageAdapter({required this.secureStorage});

  @override
  Future<String?> fetch(String key) async {
    return await secureStorage.read(key: key);
  }

  @override 
  Future<void> save({required String key, required dynamic value}) async {
    await secureStorage.write(key: key, value: value);
  }
}