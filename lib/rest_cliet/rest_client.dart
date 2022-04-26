//
// import 'package:dio/dio.dart';
//
// import 'app_constant.dart';
//
// class RestClient {
//   late Dio _dio;
//
//   RestClient._internal() {
//     _dio = Dio(
//         BaseOptions(
//           baseUrl: AppConstants.basUrl,
//         )
//     );
//   }
//
//   static final RestClient _instance = RestClient._internal();
//
//   factory RestClient() {
//     return _instance;
//   }
//
//   Dio getDio() {
//     return _dio;
//   }
// }



import 'package:dio/dio.dart';
import 'package:goldenmovie/rest_cliet/app_constant.dart';


class RestClient {
  static final _instance = RestClient._internal();

  late Dio _dio;

  RestClient._internal() {
    _dio = Dio(BaseOptions(
      connectTimeout: 20000,
      receiveTimeout: 20000,
      sendTimeout: 20000,
      baseUrl: AppConstants.basUrl,
    ));

    _dio.options.contentType = Headers.formUrlEncodedContentType;

    _dio.interceptors.addAll([
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    ]);
  }

  factory RestClient() {
    return _instance;
  }

  Dio getDio() => _dio..options.contentType = Headers.formUrlEncodedContentType;

  Dio dioByContentType(String contentType) =>
      _dio..options.contentType = contentType;
}
