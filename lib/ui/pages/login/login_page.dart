import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insight/ui/pages/login/components/email_input.dart';

import '../../helpers/helpers.dart';
import 'login.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    Get.put(presenter);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (context) {
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
                      children: [
                        const EmailInput(),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: R.strings.password
                          ),
                          obscureText: true,
                          onChanged: presenter.validatePassword
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0, top: 36.0),
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text('Enter')
                          ),
                        )
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