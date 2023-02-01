import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

RegisterGlassesPresenter makeGetxRegisterGlassesPresenter() {
  return GetxRegisterGlassesPresenter(
    addImage: makeRemoteAddImage()
  );
}