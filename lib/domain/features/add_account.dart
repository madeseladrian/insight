import '../params/params.dart';

abstract class AddAccount {
  Future<void> add({required AddAccountParams params});
}