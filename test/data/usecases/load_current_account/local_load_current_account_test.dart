import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/domain/errors/errors.dart';
import 'package:insight/domain/entities/entities.dart';

import 'package:insight/data/usecases/usecases.dart';

import '../../mocks/mocks.dart';

void main() {
  late SecureCacheStorageSpy secureCacheStorage;
  late LocalLoadCurrentAccount sut;
  late String token;

  setUp(() {
    token = faker.guid.guid();
    secureCacheStorage = SecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: secureCacheStorage);
    secureCacheStorage.mockFetch(token);
  });
 
  test('1 - Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();
    verify(() => secureCacheStorage.fetch('token'));
  });

  test('2 - Should return an AccountEntity', () async {
    final account = await sut.load();
    expect(account, AccountEntity(token: token));
  });

  test('3 - Should throw UnexpectedError if FetchSecureCacheStorage throws', () async {
    secureCacheStorage.mockFetchError();
    final future = sut.load();
    expect(future, throwsA(DomainError.unexpected));
  });
}