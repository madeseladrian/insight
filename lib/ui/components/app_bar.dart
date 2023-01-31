// ignore_for_file: annotate_overrides, overridden_fields
import 'package:flutter/material.dart';

import 'package:insight/ui/components/components.dart';

PreferredSizeWidget appBarMain = AppBar(
  backgroundColor: makeAppTheme().primaryColorDark,
  foregroundColor: Colors.white,
  centerTitle: true,
  title: const Text(
    'INSIGHT',
    style: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.bold
    ),
  ),
  actions: const [PopUpMenuButton(page: 'main')],
);

class AppBarMenu extends AppBar {
  final Color backgroundColor;
  final bool centerTitle;
  final String? nameTitle;
  final String type;

  AppBarMenu({
    super.key, 
    this.centerTitle = true,
    this.nameTitle = 'INSIGHT',
    this.backgroundColor = const Color(0xff0000b3),
    this.type = 'menu'
  });

  @override
  Widget get title => Text(
    nameTitle!.toUpperCase(),
    style: const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
  );

  @override
  List<Widget> get actions => [
    PopUpMenuButton(page: type)
  ];
}