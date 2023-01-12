import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class NameInputSignUp extends StatelessWidget {
  const NameInputSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.name,
      ),
      keyboardType: TextInputType.name,
    );
  }
}