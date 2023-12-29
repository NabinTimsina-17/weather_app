
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_constants.dart';

class HttpService{
  Dio? dio;

  HttpService(){
    dio = Dio(BaseOptions(baseUrl: baseUrl));

    initializeInterceptor();
  }

  Future<Response> getRequest(String? endpoint) async{
    Response response = await dio!.get(endpoint!, queryParameters: {
      "lat": 28.1885407,
      "lon": 84.0322231,
      "appid": "5ab38c588a5e81b2b76217f4052bac04",
      "units": "metric"
    });
    return response;
  }

  void initializeInterceptor(){
    dio!.interceptors.add(PrettyDioLogger());
  }
}