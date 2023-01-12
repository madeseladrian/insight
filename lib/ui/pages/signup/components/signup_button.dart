import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:insight/ui/pages/pages.dart';
import '../../../helpers/helpers.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});
 
  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<SignUpPresenter>();
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true 
            ? presenter.signUp : null,
          child: Text(R.strings.addAccount.toUpperCase()),
        );
      }
    );
  }
}