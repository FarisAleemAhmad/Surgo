import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../shared/services/api_client.dart';

// authentication data access layer - wraps APICLIENT. allows usage of simple commands like login(email, password)
class AuthRepository {
  final _api = ApiClient();

  Future<String> login(String email, String password) async {
    final res = await _api.post(
      '/api/auth/login',
      data: {'email': email, 'password': password},
    );

    // return access token
    final token = res.data['access_token'];
    await const FlutterSecureStorage().write(key: 'jwt', value: 'token');
    return token;
  }

  Future<void> signup(String email, String password) async {
    await _api.post(
      '/api/auth/signup',
      data: {'email': email, 'password': password},
    );
  }

  Future<void> deleteAccount() async {
    await _api.delete('/api/auth/delete');
  }
}
