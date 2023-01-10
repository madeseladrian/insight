import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/contracts/contracts.dart';

class SecureStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  SecureStorageAdapter({required this.secureStorage});

  @override 
  Future<void> save({required String key, required dynamic value}) async {
    await secureStorage.write(key: key, value: value);
  }
}