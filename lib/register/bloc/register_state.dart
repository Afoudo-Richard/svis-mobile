part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzStatus.pure,
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.username = const Email.pure(),
    this.password = const StrongPassword.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.error = '',
  });

  final FormzStatus status;
  final Name firstName;
  final Name lastName;
  final Email username;
  final StrongPassword password;
  final ConfirmPassword confirmPassword;
  final String error;

  RegisterState copyWith({
    FormzStatus? status,
    Name? firstName,
    Name? lastName,
    Email? username,
    StrongPassword? password,
    ConfirmPassword? confirmPassword,
    String? error,
  }) {
    return RegisterState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      error: error ?? '',
    );
  }

  @override
  List<Object> get props =>
      [status, firstName, lastName, username, password, confirmPassword, error];
}
