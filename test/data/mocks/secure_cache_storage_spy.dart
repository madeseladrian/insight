import 'package:mocktail/mocktail.dart';

import 'package:insight/data/contracts/contracts.dart';

class SecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage, SaveSecureCacheStorage {
  SecureCacheStorageSpy() {
    mockSave();
  }

  When mockFetchCall() => when(() => fetch(any()));
  void mockFetch(String? data) => mockFetchCall().thenAnswer((_) async => data);
  void mockFetchError() => mockFetchCall().thenThrow(Exception());

  When mockSaveCall() => when(() => save(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(Exception());
}