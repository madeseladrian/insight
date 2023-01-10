import '../entities/entities.dart';

abstract class SaveCurrentAccount {
  Future<void> save({required AccountEntity accountEntity});
}