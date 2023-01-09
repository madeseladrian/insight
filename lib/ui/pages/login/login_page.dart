import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../mixins/mixins.dart';
import 'login.dart';

class LoginPage extends StatelessWidget with LoadingManager, UIErrorManager {
  final LoginPresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    Get.put(presenter);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (context) {
          handleLoading(context, presenter.isLoadingStream);
          handleMainError(context, presenter.mainErrorStream);

          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                        EmailInput(),
                        PasswordInput(),
                        LoginButton()
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              )
            ),
          );
        }
      ),
    );
  }
}