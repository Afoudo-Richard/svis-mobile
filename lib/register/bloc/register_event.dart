part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUsernameChanged extends RegisterEvent {
  const RegisterUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class RegisterFirstNameChanged extends RegisterEvent {
  const RegisterFirstNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
class RegisterLastNameChanged extends RegisterEvent {
  const RegisterLastNameChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}


class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}
class RegisterConfirmPasswordChanged extends RegisterEvent {
  const RegisterConfirmPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
