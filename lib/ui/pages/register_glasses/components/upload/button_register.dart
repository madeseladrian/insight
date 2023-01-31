import 'package:flutter/material.dart';

import '../../../../components/components.dart';

class ButtonRegister extends StatelessWidget {
  final String? name;
  final VoidCallback onPressed;

  const ButtonRegister({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          )
        ),
        backgroundColor: MaterialStateProperty.all(makeAppTheme().primaryColorDark),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8.0))
      ),
      onPressed: onPressed,
      child: Text(
        name!.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
      ),
    );
  }
}