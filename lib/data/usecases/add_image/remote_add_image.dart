import 'dart:io';

import 'package:insight/data/models/models.dart';
import 'package:insight/domain/features/add_image.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/errors/errors.dart';

import '../../contracts/contracts.dart';
import '../../errors/errors.dart';

class RemoteAddImage implements AddImage {
  final String url;
  final HttpClient httpClient;

  RemoteAddImage({required this.url, required this.httpClient});

  @override
  Future<ImageEntity> addImage({required File image}) async {
    final body = {'image': image};
    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAddImageModel.fromJson(httpResponse).toEntity();
    } catch (error) {
      throw error == HttpError.unauthorized 
        ? DomainError.invalidCredentials
        : DomainError.unexpected;
    }
  }
}