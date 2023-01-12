import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/infra/cache/cache.dart';

import '../mocks/mocks.dart';
 
void main() {
  late String key;
  late String value;
  late FlutterSecureStorageSpy secureStorage;
  late SecureStorageAdapter sut;

  setUp(() {
    key = faker.lorem.word();
    value = faker.guid.guid();
    secureStorage = FlutterSecureStorageSpy();
    secureStorage.mockFetch(value);
    sut = SecureStorageAdapter(secureStorage: secureStorage);
  });

  group('saveSecure', () {
    test('1 - Should call save secure with correct values', () async {
      await sut.save(key: key, value: value);
      verify(() => secureStorage.write(key: key, value: value));
    });

    test('2 - Should throw if save secure throws', () async {
      secureStorage.mockSaveError();
      final future = sut.save(key: key, value: value);
      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    test('1 - Should call save secure with correct value', () async {
      await sut.fetch(key);
      verify(() => secureStorage.read(key: key));
    });
  });
}