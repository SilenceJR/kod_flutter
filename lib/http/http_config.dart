import 'package:dio/dio.dart';

class HttpClientConfig {
  final String httpBaseUrl;
  final String? proxy;
  final bool debugEnable;
  final List<Interceptor> httpInterceptors;

  HttpClientConfig.init({
    required this.httpBaseUrl,
    required this.httpInterceptors,
    this.proxy,
    this.debugEnable = true,
  });
}
