import 'package:mocktail/mocktail.dart';

import 'package:insight/domain/entities/entities.dart';
import 'package:insight/domain/features/features.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  When mockLoadCall() => when(() => load());
  void mockLoad({required AccountEntity account}) => 
    mockLoadCall().thenAnswer((_) async => account);
  void mockLoadError() => mockLoadCall().thenThrow(Exception());
}