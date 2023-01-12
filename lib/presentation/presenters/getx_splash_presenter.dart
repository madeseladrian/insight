import 'package:get/get.dart';

import '../../domain/features/features.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxSplashPresenter extends GetxController with NavigationManager implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  GetxSplashPresenter({required this.loadCurrentAccount});

  @override
  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    await loadCurrentAccount.load();
    navigateTo = '/initial';
  }
}