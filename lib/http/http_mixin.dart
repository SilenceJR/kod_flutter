import 'http_client.dart';
import 'http_config.dart';

export 'http_client.dart';

mixin DioClientMixin {
  final DioClient httpClient = DioClient(
      config: HttpClientConfig.init(
          httpBaseUrl: 'https://silence.host:18881/kod/',
          httpInterceptors: []));

  Future<String?> getHtmlString(String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) {
    return httpClient.getString(url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }
}
