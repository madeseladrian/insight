import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';
import '../login/login.dart';

import 'signup.dart';

class SignUpPage extends StatelessWidget
with LoadingManager {
  final SignUpPresenter presenter;
  
  const SignUpPage({Key? key, required this.presenter}) : super(key: key);

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

            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SignUpHeader(),
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
                          NameInputSignUp(),
                          EmailInputSignUp(),
                          PasswordInputSignUp(),
                          PasswordConfirmationInputSignUp(),
                          SignUpButton()
                        ],
                      ),
                    ),
                    Column(
                      children: [
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
