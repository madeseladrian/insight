import 'package:flutter/material.dart';

class TextWelcome extends StatelessWidget {
  final String text;

  const TextWelcome({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: Colors.grey
        ),
      ),
    );
  }
}