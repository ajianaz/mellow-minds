import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginController(),
        builder: (_) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/char_cat.png",
                        fit: BoxFit.fill,
                      ),
                      if (_.accessToken != null)
                        Text('Name: ${_.jwtPayload?.name}'),
                      if (_.accessToken == null)
                        ElevatedButton(
                          onPressed: _.login,
                          child: Text('Login'),
                        ),
                      if (_.accessToken != null)
                        ElevatedButton(
                          onPressed: _.logout,
                          child: Text('Logout'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
