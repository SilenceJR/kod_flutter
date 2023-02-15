import '../net_exception.dart';


class HttpResponse<T> {
  bool _code = false;

  bool get code => _code;

  T? _data;

  T? get data => _data;


  bool get ok => _code;

  HttpResponse.ok(T? data, {bool code=true}) {
    _data = data;
    _code = code;
  }

  HttpResponse.exception(NetException e) {
    _code = e.code;
    _data = e.message as T?;
  }

  Map<String, dynamic> toJson() => {'code': code, 'data': data};
}

extension HttpResponseExt<T> on HttpResponse<T> {
  void doFunc(
      {required Function(T? data) success,
        Function(bool code, String msg)? failure,
        Function(bool ok, bool listNoData)? finalFunc}) {
    var listNoData = false;
    if (ok) {
      success(data);
      if (data is List) {
        listNoData = (data as List?)?.isEmpty ?? true;
      }
    } else {
      failure?.call(code, data as String);
    }
    finalFunc?.call(ok, listNoData);
  }
}


// class HttpResponse<T> {
//   int _code = 0;
//
//   int get code => _code;
//
//   T? _data;
//
//   T? get data => _data;
//
//   String _msg = '';
//
//   String get msg => _msg;
//
//   bool get ok => _code == NetCode.ok || _code == NetCode.success;
//
//   HttpResponse.ok(T? data, {int? code, String msg = ''}) {
//     _data = data;
//     _code = code ?? NetCode.ok;
//     _msg = msg;
//   }
//
//   HttpResponse.exception(NetException e) {
//     _code = e.code;
//     _msg = e.message;
//   }
//
//   Map<String, dynamic> toJson() => {'code': code, 'data': data, 'msg': msg};
// }

// extension HttpResponseExt<T> on HttpResponse<T> {
//   void doFunc(
//       {required Function(T? data) success,
//       Function(int code, String msg)? failure,
//       Function(bool ok, bool listNoData)? finalFunc}) {
//     var listNoData = false;
//     if (ok) {
//       success(data);
//       if (data is List) {
//         listNoData = (data as List?)?.isEmpty ?? true;
//       }
//     } else {
//       failure?.call(code, msg);
//     }
//     finalFunc?.call(ok, listNoData);
//   }
// }
