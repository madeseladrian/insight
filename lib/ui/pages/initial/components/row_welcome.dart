import 'package:flutter/material.dart';

import 'package:insight/ui/components/components.dart';

class RowWelcome extends StatelessWidget {
  final int number;
  final String text;

  const RowWelcome({
    super.key, 
    required this.number, 
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: makeAppTheme().primaryColorDark,
              ),
              child: Text(
                number.toString(),
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}