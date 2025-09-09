import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// makes a DIO class with an interceptor that allows injection of JWT tokens
class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000', // android emulator to localhost
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  final _storage = const FlutterSecureStorage();

  ApiClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // read JWT from secure storage and attach as bearer header
          final token = await _storage.read(key: 'jwt');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  // add POST method
  Future<Response> post(String path, {Map<String, dynamic>? data}) =>
      _dio.post(path, data: data);

  // add GET method
  Future<Response> get(String path) => _dio.get(path);

  // add DELETE method
  Future<Response> delete(String path, {Map<String, dynamic>? data}) =>
      _dio.delete(path, data: data);
}
