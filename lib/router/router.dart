import 'package:get/get.dart';

import '../controller/login_cl.dart';
import '../ui/login_ui.dart';

enum RoutePath {
  login('/login');

  const RoutePath(this.path);

  final String path;

  String get name => path;
}

RoutePath get initPage => RoutePath.login;

final appPages = <GetPage>[
  GetPage(
      name: RoutePath.login.name,
      page: () => const LoginUI(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())))
];
