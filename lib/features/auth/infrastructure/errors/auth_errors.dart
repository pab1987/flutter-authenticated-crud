class WrongCredentials implements Exception {}
class InvalidToken implements Exception {}
class ConnectionTimeout implements Exception {}

class CustomError implements Exception {
  final String message;
  //final int errorCode;

  //TODO: Implementar la personalización de errores interceptando la exception

  CustomError( this.message);

}


