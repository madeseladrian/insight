import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../helpers/i18n/i18n.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
            onTap: () {}
          )
        ],
      )
    );
  }
}