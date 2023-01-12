import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:insight/presentation/presenters/presenters.dart';

import '../../domain/mocks/mocks.dart';

void main() {
  late GetxSplashPresenter sut;
  late LoadCurrentAccountSpy loadCurrentAccount;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    loadCurrentAccount.mockLoad(account: EntityFactory.makeAccount());
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  setUpAll(() {
    registerFallbackValue(EntityFactory.makeAccount());
  });
 
  test('1 - Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);
    verify(() => loadCurrentAccount.load()).called(1);
  });

  test('2 - Should go to initial page on success', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/initial')));

    await sut.checkAccount(durationInSeconds: 0);
  });
}