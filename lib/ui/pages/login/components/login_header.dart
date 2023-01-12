import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/components.dart';
import '../../../helpers/i18n/i18n.dart';
import '../login.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<LoginPresenter>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          HeaderTextWidget(
            name: R.strings.login,
            onTap: () {},
          ),
          HeaderTextWidget(
            key: const Key('support header'),
            name: R.strings.support,
            onTap: presenter.support,
          )
        ],
      )
    );
  }
}