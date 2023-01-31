import 'package:get/get.dart';
import 'package:insight/ui/pages/pages.dart';

import '../mixins/mixins.dart';

class GetxInitialPresenter extends GetxController with NavigationManager
implements InitialPresenter {

  @override
  void goToCamera() {
    navigateTo = '/camera';
  }
}