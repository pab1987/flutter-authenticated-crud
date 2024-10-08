import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordError { empty, length, format, mismatch }

// Extend FormzInput and provide the input type and error type.
class ConfirmPassword extends FormzInput<String, PasswordError> {

  final String password;

  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ConfirmPassword.dirty( {required String value, required this.password} ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == PasswordError.empty ) return 'El campo es requerido';
    if ( displayError == PasswordError.length ) return 'Mínimo 6 caracteres';
    if ( displayError == PasswordError.format ) return 'Debe de tener Mayúscula, letras y un número';
    if ( displayError == PasswordError.mismatch) return 'Las contraseñas no coinciden';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  PasswordError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return PasswordError.empty;
    if ( value.length < 6 ) return PasswordError.length;
    if ( !passwordRegExp.hasMatch(value) ) return PasswordError.format;
    if ( value != password ) return PasswordError.mismatch;

    return null;
  }
}