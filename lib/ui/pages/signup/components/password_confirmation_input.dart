import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';
 
class PasswordConfirmationInputSignUp extends StatelessWidget {
  const PasswordConfirmationInputSignUp({ Key? key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: R.strings.passwordConfirmation,
        ),
        obscureText: true,
      ),
    );
  }
}