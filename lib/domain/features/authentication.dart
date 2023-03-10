import '../entities/entities.dart';
import '../params/params.dart';

abstract class Authentication {
  Future<AccountEntity> auth({required AuthenticationParams params});
}