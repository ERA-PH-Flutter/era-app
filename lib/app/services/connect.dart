import 'package:dio/dio.dart';

class AppConnect{
  var dio = Dio();
  post(url,data)async{
    var response = await dio.post(url,data: data);
    return response;
  }
  get(url,Map data)async{
    var response = await dio.get(url);
    return response;
  }
}