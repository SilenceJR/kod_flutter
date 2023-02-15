import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_cl.dart';

class LoginUI extends GetView<LoginController> {
  const LoginUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: controller.userTextController,
              ),
              TextField(
                controller: controller.passwordTextController,
              ),
              ElevatedButton(onPressed: controller.login, child: Text('登录'))
            ],
          ),
        ),
      ),
    );
  }
}
