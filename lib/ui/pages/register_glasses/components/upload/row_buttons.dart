import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../register_glasses.dart';

class RowButtons extends StatelessWidget {
  const RowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<RegisterGlassesPresenter>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonRegister(
          name: 'Câmera',
          onPressed: presenter.getCamera,
        ),
        const SizedBox(width: 8.0),
        ButtonRegister(
          name: 'Galeria',
          onPressed: presenter.getGalery,
        )
      ],
    );
  }
}