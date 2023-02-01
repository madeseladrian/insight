import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/components.dart';
import '../../pages.dart';

// class RegisterGlassesButton extends StatelessWidget {
//   const RegisterGlassesButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const DefaultButton(
//       key: Key('register glasses'),
//       nameButton: 'Cadastrar Óculos', 
//       onPressed: null
//     );
//   }
// }

class RegisterGlassesButton extends StatelessWidget {
  const RegisterGlassesButton({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<RegisterGlassesPresenter>();
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return DefaultButton(
          key: const Key('register glasses'),
          nameButton: 'Cadastrar Óculos', 
          onPressed: snapshot.data == true ? presenter.uploadPhotos : null
        );
      }
    );
  }
}