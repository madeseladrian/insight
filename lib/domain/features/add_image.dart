import 'dart:io';

import '../entities/entities.dart';

abstract class AddImage {
  Future<ImageEntity> addImage({required File image});
}