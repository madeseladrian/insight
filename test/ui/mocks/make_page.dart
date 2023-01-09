import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:insight/ui/components/components.dart';

ThemeData get themeData => makeAppTheme();

Widget makePage({required String path, required Widget Function() page}) {
  final getPages = [
    GetPage(name: path, page: page)
  ];

  return GetMaterialApp(
    initialRoute: path,
    theme: themeData,
    getPages: getPages,
  );
}