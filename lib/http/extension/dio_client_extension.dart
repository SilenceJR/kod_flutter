part of http_client;

extension DioClientExt on DioClient {
  Future<HttpResponse<T?>> getAccept<T>(String url,
      {dynamic body,
      bool? encrypt,
      T? Function(dynamic data)? dataDecoder,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    Response? response;
    bool code = false;
    try {
      response = await get(url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.response:
        case DioErrorType.other:

          /// 统一错误处理
          break;
        case DioErrorType.cancel:
          break;
      }
    }

    if (null != response) {
      final data = jsonDecode(response.data);
      try {
        code = data['code'] as bool;
        if (code) {
          if (null != dataDecoder) {
            return HttpResponse.ok(dataDecoder(data['data']), code: code);
          } else {
            return HttpResponse.ok(data['data'], code: code);
          }
        } else {}
      } on Exception catch (e) {
        return HttpResponse.exception(
            NetException(code, defaultMsg: data['data']));
      }
    }

    return HttpResponse.exception(NetException(code, defaultMsg: ''));
  }

  Future<HttpResponse<T?>> postAccept<T>(String url,
      {dynamic body,
      bool? encrypt,
      T? Function(dynamic data)? dataDecoder,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    Response? response;
    bool code = false;
    try {
      response = await post(url,
          body: body,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.response:
        case DioErrorType.other:

          /// 统一错误处理
          break;
        case DioErrorType.cancel:
          break;
      }
    }

    if (null != response) {
      final data = jsonDecode(response.data);
      try {
        code = data['code'] as bool;
        if (code) {
          if (null != dataDecoder) {
            return HttpResponse.ok(dataDecoder(data['data']), code: code);
          } else {
            return HttpResponse.ok(data as T?, code: code);
          }
        } else {}
      } on Exception catch (e) {
        return HttpResponse.exception(
            NetException(code, defaultMsg: data['data']));
      }
    }

    return HttpResponse.exception(NetException(code, defaultMsg: ''));
  }
}
