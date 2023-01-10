import 'package:mocktail/mocktail.dart';

import 'package:insight/data/contracts/contracts.dart';

class SecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
  SecureCacheStorageSpy() {
    mockSave();
  }

  When mockSaveCall() => when(() => save(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(Exception());
}