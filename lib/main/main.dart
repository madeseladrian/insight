import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import '../ui/components/components.dart';
import '../ui/helpers/helpers.dart';
import 'factories/factories.dart';

void main() {
  R.load(const Locale('pt', 'BR'));
  //R.load(const Locale('en', 'US'));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    
    return GetMaterialApp(
      title: 'Insight',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage),
        GetPage(name: '/login', page: makeLoginPage),
        GetPage(name: '/signup', page: makeSignUpPage),
        GetPage(name: '/glasses', page: makeRegisterGlassesPage),
        GetPage(name: '/initial', page: makeInitialPage),
        GetPage(name: '/support', page: () => const Scaffold(body: Center(child: Text('Support')))),
        GetPage(name: '/camera', page: () => const Scaffold(body: Center(child: Text('Camera')))),
        GetPage(name: '/recoverPassword', page: () => const Scaffold(body: Center(child: Text('Recover Password')))),
      ]
    );
  }
}