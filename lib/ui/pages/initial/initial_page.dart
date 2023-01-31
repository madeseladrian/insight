import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'components/components.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Tire uma Foto',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextWelcome(
                text: 'Nós usamos inteligência artificial'
              ),
              TextWelcome(
                text: 'para indicar o óculos mais'
              ),
              TextWelcome(
                text: 'adequado a você'
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 75,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/self.png'),
                    radius: 70
                  ),
                )
              ),
              RowWelcome(
                number: 1,
                text: 'Garanta uma boa iluminação',
              ),
              RowWelcome(
                number: 2,
                text: 'Olhe direto para a câmera',
              ),
              RowWelcome(
                number: 3,
                text: 'Tire a foto'
              ),
              RowWelcome(
                number: 4,
                text: 'Pronto! É só escolher o óculos'
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: DefaultButton(
        nameButton: 'tirar foto', 
        onPressed: () {}
      )
    );
  }
}