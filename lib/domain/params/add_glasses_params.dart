import 'package:equatable/equatable.dart';

class AddGlassesParams extends Equatable {
  final String? urlImage;
  final String? glassesId;
  final String? model;
  final String? format;
  final String? gender;
  final String? public;
  final String? category;
  final String? frameColor;
  final String? lensColor;
  final String? sizeLens;
  final String? sizeBridge;
  final String? heightFrame;
  final String? sizeTemples;
  final String? price;
  final String? additionalInfo;

  @override
  List get props => [
    urlImage,
    glassesId,
    model,
    format,
    gender,
    public,
    category,
    frameColor,
    lensColor,
    sizeLens,
    sizeBridge,
    heightFrame,
    sizeTemples,
    price,
    additionalInfo,
  ];

  const AddGlassesParams({
    required this.urlImage,
    required this.glassesId,
    required this.model,
    required this.format,
    required this.gender,
    required this.public,
    required this.category,
    required this.frameColor,
    required this.lensColor,
    required this.sizeLens,
    required this.sizeBridge,
    required this.heightFrame,
    required this.sizeTemples,
    required this.price,
    required this.additionalInfo,
  });
}