import 'package:faker/faker.dart';

import 'package:insight/domain/params/params.dart';

class ParamsFactory {
  static AuthenticationParams makeAuthentication() => AuthenticationParams(
    email: faker.internet.email(),
    password: faker.internet.password()
  );
}