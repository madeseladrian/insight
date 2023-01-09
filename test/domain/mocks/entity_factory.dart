import 'package:faker/faker.dart';

import 'package:insight/domain/entities/entities.dart';

class EntityFactory {
  static AccountEntity makeAccount() => AccountEntity(
    token: faker.guid.guid()
  );
}