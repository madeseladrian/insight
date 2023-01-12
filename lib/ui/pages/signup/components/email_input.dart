import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class EmailInputSignUp extends StatelessWidget {
  const EmailInputSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.email,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: null
    );
  }
}