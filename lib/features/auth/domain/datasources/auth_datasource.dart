//! En domain van las reglas de negocio. No va a ser la implementación, solo la definición de 
//! como quiero que sean empleadas todos los sistemas de autenticación de mi sistema
//! ayuda a cambiarlo facil en un futuro

import 'package:teslo_shop/features/auth/domain/domain.dart';

abstract class AuthDatasource {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> checkAuthStatus(String token);
}