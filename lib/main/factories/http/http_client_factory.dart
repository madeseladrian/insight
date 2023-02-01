import 'package:http/http.dart';

import '../../../infra/http/http.dart';
import '../factories.dart';

HttpAdapter makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(
    client: client, 
    loadCurrentAccount: makeLocalLoadCurrentAccount()
  );
}