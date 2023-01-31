import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import 'initial.dart';

Widget makeInitialPage() {
  return InitialPage(presenter: makeGetxInitialPresenter());
}