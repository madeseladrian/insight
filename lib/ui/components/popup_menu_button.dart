import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PopUpMenuButton extends StatelessWidget {
  final String? page;

  const PopUpMenuButton({super.key, required this.page});

  static List<String> itemsMenu = [
    'Cadastrar Óculos',
    'Itens Cadastrados',
    'Suporte',
    'Sair'
  ];

  @override
  Widget build(BuildContext context) {
    
    void escolhaMenuItem(String itemEscolhido){
      switch(itemEscolhido){
        case 'Cadastrar Óculos':
          page == 'main' ? Get.toNamed('/glasses') : Get.offAllNamed('/glasses');
          break;
        case 'Itens Cadastrados':
          page == 'main' ? Get.toNamed('/registerGlasses') : Get.offAllNamed('/registerGlasses');
          break;
        case 'Suporte':
          page == 'main' ? Get.toNamed('/support') : Get.offAllNamed('/support');
          break;
        case 'Sair':
          Get.offAllNamed('/login');
          break;
      }
    }

    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: Colors.white),
      color: Colors.white,
      onSelected: escolhaMenuItem,           // Define o método selecionado pelo usuário
      itemBuilder: (context){                //'context' constroe os itens que vão ser exibidos
        return itemsMenu.map((String item){  //'itensMenu' lista de itens e vamos percorrer usando um 'map'
          return PopupMenuItem<String>(      // Exibe os itens
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black
              ),
            ),
          );
        }).toList();                         // Por último converte numa lista de novo
      },
    );
  }
}