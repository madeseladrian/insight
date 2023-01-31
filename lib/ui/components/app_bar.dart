import 'package:flutter/material.dart';

import 'package:insight/ui/components/components.dart';


PreferredSizeWidget appBarMain = AppBar(
  backgroundColor: makeAppTheme().primaryColorDark,
  centerTitle: true,
  title: const Text(
    'INSIGHT',
    style: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
  ),
  actions: const [PopUpMenuButton(page: 'main')],
);

PreferredSizeWidget appBarMenu = AppBar(
  backgroundColor: makeAppTheme().primaryColorDark,
  centerTitle: true,
  title: const Text(
    'INSIGHT',
    style: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
  ),
  actions: const [PopUpMenuButton(page: 'menu')],
);
