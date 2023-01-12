import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';
import 'login.dart';

class LoginPage extends StatelessWidget with LoadingManager, NavigationManager, UIErrorManager {
  final LoginPresenter presenter;

  const LoginPage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {    
    Get.put(presenter);
    
    return Container(
      decoration: boxImage,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(
          builder: (context) {
            handleLoading(context, presenter.isLoadingStream);
            handleMainError(context, presenter.mainErrorStream);
            handleNavigation(presenter.navigateToStream);

            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginHeader(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: const EdgeInsets.only(right: 24, left: 24, top: 16, bottom: 16),
                      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          EmailInputLogin(),
                          PasswordInputLogin(),
                          LoginButton()
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        HelpLogin(
                          key: const Key('recover password'),
                          text: R.strings.forgotPassword, 
                          routeText: R.strings.recoverPassword, 
                          onTap: presenter.recoverPassword
                        ),
                        HelpLogin(
                          key: const Key('support body'),
                          text: R.strings.needHelp, 
                          routeText: R.strings.clickHere, 
                          onTap: presenter.support
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                )
              ),
            );
          }
        ),
      ),
    );
  }
}