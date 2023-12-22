
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_constants.dart';

class HttpService{
  Dio? dio;

  HttpService(){
    dio = Dio(BaseOptions(baseUrl: baseUrl));

    initializeInterceptor();
  }

  Future<Response> getRequest() async{
    Response response = await dio!.get("");
    return response;
  }

  void initializeInterceptor(){
    dio!.interceptors.add(PrettyDioLogger());
  }
}