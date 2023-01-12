import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.dart';
import '../signup.dart';
 
class PasswordInputSignUp extends StatelessWidget {
  const PasswordInputSignUp({super.key});
 
  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<SignUpPresenter>();
    return StreamBuilder<UIError?>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.strings.password,
            errorText: snapshot.data?.description
          ),
          obscureText: true,
          onChanged: presenter.validatePassword
        );
      }
    );
  }
}