part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.rememberMe = const BooleanInput.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final BooleanInput rememberMe;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    BooleanInput? rememberMe,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object> get props => [status, username, password, rememberMe];
}
