import 'package:flutter/material.dart';
import 'package:kod_flutter/base/base_cl.dart';
import 'package:kod_flutter/http/model/response.dart';

class LoginController extends BaseController{
  late TextEditingController userTextController;
  late TextEditingController passwordTextController;

  @override
  void onInit() {
    super.onInit();
    userTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  void login() async{
    // final result = await api.login(name: userTextController.text, password: passwordTextController.text);
    final result = await api.login(name: 'Silence', password: 'PJhk02261993');
    result.doFunc(success: (data){
      print('token: $data');
    });
  }

  @override
  void onClose() {
    userTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
