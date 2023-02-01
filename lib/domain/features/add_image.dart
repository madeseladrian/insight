import 'dart:io';

import '../entities/entities.dart';

abstract class AddImage {
  Future<ImageEntity> add({required File image});
}