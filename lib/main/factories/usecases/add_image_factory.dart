import '../../../domain/features/features.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

AddImage makeRemoteAddImage() {
  return RemoteAddImage(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl('image')
  );
}