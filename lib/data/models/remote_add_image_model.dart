import '../../domain/entities/entities.dart';

import '../errors/errors.dart';

class RemoteAddImageModel {
  final String? glassesId;
  final String? urlImage;

  RemoteAddImageModel({required this.glassesId, required this.urlImage});

  factory RemoteAddImageModel.fromJson(Map json) {
    if (!json.containsKey('glasses_id')) {
      throw HttpError.invalidData;
    }
    if (!json.containsKey('url_image')) {
      throw HttpError.invalidData;
    }
    return RemoteAddImageModel(
      glassesId: json['glasses_id'],
      urlImage: json['url_image']
    );
  }

  ImageEntity toEntity() => ImageEntity(
    glassesId: glassesId,
    urlImage: urlImage
  );
}