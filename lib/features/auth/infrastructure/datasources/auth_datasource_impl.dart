//! Esta será la implementación del datasource

import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/auth/check-status', 
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw CustomError('Token caducado');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'email': email, 'password': password});
      return UserMapper.userJsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas');
      if (e.type == DioExceptionType.connectionTimeout) throw CustomError('Revisar conexión a internet');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    try {
      final response = await dio
          .post('/auth/register', data: {'fullName': fullName, 'email': email, 'password': password});
      return UserMapper.userJsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) throw CustomError(e.response?.data['message'] ?? 'Error en la creación de usuario');
      if (e.type == DioExceptionType.connectionTimeout) throw CustomError('Revisar conexión a internet');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
