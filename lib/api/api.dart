
import '../http/http_mixin.dart';
import '../http/model/response.dart';

const _api = '/api';

class Api with DioClientMixin {
  Api._();

  static Api instance = Api._();

  // >>>>>>>>>>>>>>>>>>>>>>>>>  api <<<<<<<<<<<<<<<<<<<<<<<<<<

  //user/loginSubmit&isAjax=1&getToken=1&name=[用户名]&password=[密码]
  Future<HttpResponse<String?>> login(
      {required String name, required String password}) async {
    final paraMap = {
      'name': name,
      'password': password,
      'isAjax': 1,
      'getToken': 1
    };
    const url = '?user/loginSubmit';
    return httpClient.getAccept(url, body: paraMap);
  }
}
