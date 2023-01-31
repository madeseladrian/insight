import 'dart:io';

abstract class AddImage {
  Future<void> addImage({required File image});
}