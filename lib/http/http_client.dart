library http_client;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'http_config.dart';
import 'model/response.dart';
import 'net_exception.dart';

export 'package:dio/dio.dart';

part 'extension/dio_client_extension.dart';

class DioClient {
  static const utf8Decoder = Utf8Decoder();

  final Dio _dio;

  final HttpClientConfig config;

  DioClient({required this.config}) : _dio = Dio() {
    _dio.options
      ..baseUrl = config.httpBaseUrl
      ..connectTimeout = 30000
      ..receiveTimeout = 30000
      ..sendTimeout = 30000;
    _dio.interceptors.addAll(config.httpInterceptors);
    if (config.debugEnable) {
      _dio.interceptors.add(LogInterceptor(
          requestBody: true, responseBody: true, logPrint: (msg) {
            log(msg.toString(),time: DateTime.now(), name: 'dio');
      }));
    }

    if (config.debugEnable) {}

    if (null != config.proxy) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client
          ..findProxy = (uri) {
            return '${config.proxy}';
          }
          //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        return null;
      };
    }
  }

  void clearHttpTask() {
  }

  Future<Response> downLoad(
    String urlPath,
    savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    Options? options,
  }) {
    return _dio.download(urlPath, savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: options);
  }

  Future<String?> getString(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    var response = await get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
    return response.data?.toString();
  }

  Future<Response<T>> head<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) {
    return _dio.head(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,);
  }


  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<T>> post<T>(String url,
      {dynamic body,
      T? Function(dynamic data)? dataDecoder,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    return _dio.post(url,
        data: body,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response> postFiles(String url,
      {required List<String> paths,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    var data = FormData();
    for (var path in paths) {
      data.files.add(MapEntry(
          'file${paths.indexOf(path)}', MultipartFile.fromFileSync(path)));
    }
    return _dio.post(url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }
}
