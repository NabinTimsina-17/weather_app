import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_constants.dart';

class HttpService {
  Dio dio;

  HttpService() : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    initializeInterceptor();
  }

  Future<Response> getRequest(String endpoint) async {
    try {
      Response response = await dio.get(
        endpoint,
        queryParameters: {
          "lat": 28.1885407,
          "lon": 84.0322231,
          "appid": "39857143a14a6e99b22ede2ca6b07b13",  // Replace with actual key securely
          "units": "metric"
        },
      );
      return response;
    } catch (e) {
      rethrow; // Or handle the error here
    }
  }

  void initializeInterceptor() {
    dio.interceptors.add(PrettyDioLogger());
  }
}
