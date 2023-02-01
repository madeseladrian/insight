import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/entities.dart';
import '../../domain/errors/errors.dart';
import '../../domain/features/features.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

import '../mixins/mixins.dart';

class GetxRegisterGlassesPresenter extends GetxController 
with FormManager, NavigationManager implements RegisterGlassesPresenter {
  final AddImage addImage;

  File? _imageFile;

  final _image = Rx<File?>(null);

  @override
  Stream<File?> get imageStream => _image.stream;

  GetxRegisterGlassesPresenter({
    required this.addImage
  });

  final ImagePicker _picker = ImagePicker();

  void _validateForm() {
    isFormValid = _image.value != null;
  }

  @override
  void getCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    _image.value = File(photo!.path);
    _imageFile = File(photo.path);
    _validateForm();
  }

  @override
  void getGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _image.value = File(image!.path);
    _imageFile = File(image.path);
    _validateForm();
  }

  @override
  Future<ImageEntity> uploadPhotos() async {
    try {
      final imageEntity =  await addImage.add(image: _imageFile!);
      navigateTo = 'glasses';
      _image.value = null;
      return imageEntity;
    } on DomainError {
      throw UIError.unexpected;
    }
  }
}