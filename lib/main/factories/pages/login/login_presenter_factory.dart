import 'package:insight/domain/entities/account_entity.dart';

import '../../../../domain/features/features.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

class Save implements SaveCurrentAccount {
  @override
  Future<void> save({required AccountEntity accountEntity}) {
    // TODO: implement save
    throw UnimplementedError();
  }
}

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
    authentication: makeRemoteAuthentication(),
    saveCurrentAccount: Save(),
    validation: makeLoginValidation(),
  );
}