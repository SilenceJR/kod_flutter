import 'http_mixin.dart';

class HttpApi with DioClientMixin {
  HttpApi._();

  static HttpApi instance = HttpApi._();
}
