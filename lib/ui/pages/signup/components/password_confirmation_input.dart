import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.dart';
import '../signup.dart';
 
class PasswordConfirmationInputSignUp extends StatelessWidget {
  const PasswordConfirmationInputSignUp({super.key});
 
  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<SignUpPresenter>();
    return StreamBuilder<UIError?>(
      stream: presenter.passwordConfirmationErrorStream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 32),
          child: TextFormField(
            key: const Key('passwordConfirmation-input-signup'),
            decoration: InputDecoration(
              labelText: R.strings.passwordConfirmation,
              errorText: snapshot.data?.description
            ),
            obscureText: true,
            onChanged: presenter.validatePasswordConfirmation
          ),
        );
      }
    );
  }
}