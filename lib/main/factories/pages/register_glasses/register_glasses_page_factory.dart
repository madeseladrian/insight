import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import 'register_glasses.dart';

Widget makeRegisterGlassesPage() {
  return RegisterGlassesPage(presenter: makeGetxRegisterGlassesPresenter());
}