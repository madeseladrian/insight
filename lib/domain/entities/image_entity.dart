import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String? glassesId;
  final String? urlImage;

  @override 
  List get props => [glassesId, urlImage];

  const ImageEntity({this.glassesId, this.urlImage});
}