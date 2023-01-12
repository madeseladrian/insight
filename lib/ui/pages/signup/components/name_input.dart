import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insight/ui/pages/pages.dart';

import '../../../helpers/helpers.dart';

class NameInputSignUp extends StatelessWidget {
  const NameInputSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<SignUpPresenter>();
    return StreamBuilder<UIError?>(
      stream: presenter.nameErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.strings.name,
            errorText: snapshot.data?.description
          ),
          keyboardType: TextInputType.name,
          onChanged: presenter.validateName,
        );
      }
    );
  }
}