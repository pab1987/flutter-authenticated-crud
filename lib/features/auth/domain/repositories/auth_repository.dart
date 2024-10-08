//! El repositorio es quien va  a terminar teniendo en la implementación la definición del datasource 
//! que vamos a utilizar para autenticarnos
import 'package:teslo_shop/features/auth/domain/domain.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String fullName, String email, String password, String confirmPassword);
  Future<User> checkAuthStatus(String token);
}