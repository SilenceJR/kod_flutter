import 'package:kod_flutter/api/api.dart';
import 'package:kod_flutter/http/model/response.dart';

final api = Api.instance;

void main() async{
  final result = await api.login(name: 'Silence', password: 'PJhk02261993');
  result.doFunc(success: (data){
    print('data: $data');
  });
}