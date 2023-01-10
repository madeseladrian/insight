import '../../../domain/features/features.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

Authentication makeRemoteAuthentication() {
  return RemoteAuthentication(
    url: makeApiUrl('login'), 
    httpClient: makeHttpAdapter()
  );
}