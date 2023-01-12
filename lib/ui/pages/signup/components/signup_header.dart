import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
import '../signup.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<SignUpPresenter>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          HeaderTextWidget(
            key: const Key('login header'),
            name: R.strings.login,
            onTap: presenter.goToLogin,
          ),
          HeaderTextWidget(
            key: const Key('support header'),
            name: R.strings.support,
            onTap: () {}
          )
        ],
      )
    );
  }
}