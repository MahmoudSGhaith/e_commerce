

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkServices {
  NetworkServices(){
    init();
  }
  late Dio dio;

  void init(){
    dio = Dio(
        BaseOptions(
          baseUrl: "https://ecommerce.routemisr.com/api/v1/",
          followRedirects: false,
        )
    );
    dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
    ));
  }
}