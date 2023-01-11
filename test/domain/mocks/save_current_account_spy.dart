import 'package:mocktail/mocktail.dart';

import 'package:insight/domain/errors/errors.dart';
import 'package:insight/domain/features/features.dart';

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {
  SaveCurrentAccountSpy() {
    mockSave();
  }

  When mockSaveCall() => when(() => save(accountEntity: any(named: 'accountEntity')));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(DomainError.unexpected);
}