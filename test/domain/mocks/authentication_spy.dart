import 'package:mocktail/mocktail.dart';

import 'package:insight/domain/entities/entities.dart';
import 'package:insight/domain/errors/errors.dart';
import 'package:insight/domain/features/features.dart';

class AuthenticationSpy extends Mock implements Authentication {
  When mockAuthenticationCall() => when(() => auth(params: any(named: 'params')));
  void mockAuthentication(AccountEntity data) => 
    mockAuthenticationCall().thenAnswer((_) async => data);
  void mockAuthenticationError(DomainError error) => 
    mockAuthenticationCall().thenThrow(error);
}