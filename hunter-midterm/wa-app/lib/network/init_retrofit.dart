import 'package:dio/dio.dart';
import 'package:wa_app/network/api_service.dart';

class InitRetrofit {
  late String _token;

  static ApiService? apiService;

  init(String token) async {
    _token = token;
    final dio = await createDio();
    apiService = ApiService(dio);
  }

  Future<Dio> createDio() async {
    final dio = Dio(BaseOptions(connectTimeout: 50000, receiveTimeout: 50000));
    addInterceptors(dio);
    return dio;
  }

  Dio addInterceptors(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) => tokenInterceptor(options, handler)));
    dio.interceptors.add(LogInterceptor(responseBody: true, request: true));
    return dio;
  }

  dynamic tokenInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      //options.headers.addAll({"Authorization": "Bearer $_token"});
      options.headers.addAll(
          {"Authorization": "Bearer $_token", "Accept": "application/json"});
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return handler.next(options);
  }

  dynamic authInterceptors(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      //options.headers.addAll({"Authorization": "Bearer $_token"});
      options.headers.addAll(
          {"Authorization": "Bearer $_token", "Accept": "application/json"});
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return handler.next(options);
  }
}
