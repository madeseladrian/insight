import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../register_glasses/register_glasses.dart';
import '../../components/components.dart';

class RegisterGlassesPage extends StatelessWidget {
  final RegisterGlassesPresenter presenter;

  const RegisterGlassesPage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    Get.put(presenter);
    
    return Scaffold(
      appBar: AppBarMenu(nameTitle: 'Cadastrar Óculos'),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) {
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  UploadPhotos(),
                  RegisterGlassesButton()
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}