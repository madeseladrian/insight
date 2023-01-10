import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/domain/entities/entities.dart';
import 'package:insight/data/usecases/usecases.dart';

import '../../mocks/mocks.dart';

void main() {
  late AccountEntity accountEntity;
  late SecureCacheStorageSpy secureCacheStorage;
  late LocalSaveCurrentAccount sut;

  setUp(() {
    accountEntity = AccountEntity(token: faker.guid.guid());
    secureCacheStorage = SecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: secureCacheStorage);
  });

  test('1 - Should call SecureCacheStorage with correct values', () async {
    await sut.save(accountEntity: accountEntity);
    verify(() => secureCacheStorage.save(
      key: 'token', value: accountEntity.token
    ));
  });
}