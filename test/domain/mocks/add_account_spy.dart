import 'package:mocktail/mocktail.dart';

import 'package:insight/domain/entities/entities.dart';
import 'package:insight/domain/errors/errors.dart';
import 'package:insight/domain/features/features.dart';

class AddAccountSpy extends Mock implements AddAccount {
  When mockAddAccountCall() => when(() => add(params: any(named: 'params')));
  void mockAddAccount(AccountEntity data) => 
    mockAddAccountCall().thenAnswer((_) async => data);
  void mockAddAccountError(DomainError error) => mockAddAccountCall().thenThrow(error);
}