import 'package:flutter/material.dart';

import 'package:insight/ui/components/components.dart';

class DefaultButton extends StatelessWidget {
  final String nameButton;
  final VoidCallback? onPressed;

  const DefaultButton({
    super.key,
    required this.nameButton,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        height: 46,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              makeAppTheme().primaryColorDark
            )
          ),
          child: Text(
            nameButton.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}