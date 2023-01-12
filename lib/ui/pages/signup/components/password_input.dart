import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';
 
class PasswordInputSignUp extends StatelessWidget {
  const PasswordInputSignUp({ Key? key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.password,
      ),
      obscureText: true
    );
  }
}