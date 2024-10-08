//! 1. State del provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/confirm_password.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Name fullName;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;

  RegisterFormState({
    this.isPosting = false, 
    this.isFormPosted = false, 
    this.isValid = false, 
    this.fullName = const Name.pure(),
    this.email = const Email.pure(), 
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Name? fullName,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
  );

  @override
  String toString() {
    return '''
      isPosting $isPosting
      isFormPosted $isFormPosted
      isValid $isValid
      fullName $fullName
      email $email
      password $password
      confirmpassword $confirmPassword
    ''';
  }
}
//! 2. Como implementamos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {

  final Function(String, String, String, String) registerUserCallback; 

  RegisterFormNotifier({required this.registerUserCallback}): super( RegisterFormState() );

  onNameChange(String value) {
    final newName = Name.dirty(value);

    state = state.copyWith(
      fullName: newName,
      isValid: Formz.validate([newName, state.email, state.password, state.confirmPassword])
    );
  }

  onEmailChange( String value ) {
    final newEmail = Email.dirty(value);

    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.fullName, state.password, state.confirmPassword])
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.fullName, state.email,state.confirmPassword])
    );
  }

  onConfirmPasswordChange(String value) {
    final newConfirmPassword = ConfirmPassword.dirty(
      value: value,
      password: state.password.value
    );

    state = state.copyWith(
      confirmPassword: newConfirmPassword,
      isValid: Formz.validate([newConfirmPassword, state.fullName, state.password, state.email])
    );
  }

  onFormSubmit() async {

    print('****** Entra al onFormSubmit ***********');

    _touchEveryField();

    print('Name: ${state.fullName}');
    print('Email: ${state.email}');
    print('Password: ${state.password}');
    print('ConfirmPassword: ${state.confirmPassword}');
    print('IsValid: ${state.isValid}');

    if (!state.isValid) return;
    //* Quitar print
    print('State: $state');

  await registerUserCallback(state.fullName.value, state.email.value, state.password.value, state.confirmPassword.value );
    
  }

  _touchEveryField() {
    final name      = Name.dirty(state.fullName.value);
    final email     = Email.dirty(state.email.value);
    final password  = Password.dirty(state.password.value);
    final confirmPassword  = ConfirmPassword.dirty(
      value: state.confirmPassword.value,
      password: state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      fullName: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([name, email, password, confirmPassword])
    );
  }
  
}
//! 3. StateNotifierProvider - Se consume afuera
//* Se agrega el autoDispose para que cuando el usuario salga de la pantalla de registro, al volver no aparezca la info
//* del email y el password
final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {

  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
  
});