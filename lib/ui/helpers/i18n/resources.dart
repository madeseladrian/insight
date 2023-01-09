import 'package:flutter/material.dart';

import 'strings/strings.dart';

class R {
  static Translation strings = PtBr();

  static void load(Locale locale) {
    switch (locale.toString()) {
      case 'en_US': strings = EnUs(); break;
      default: strings = PtBr(); break;
    }
  }
}