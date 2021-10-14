part of 'password_update_bloc.dart';

abstract class PasswordUpdateEvent extends Equatable {
  const PasswordUpdateEvent();

  @override
  List<Object> get props => [];
}

class PasswordUpdateOldPasswordChanged extends PasswordUpdateEvent {
  const PasswordUpdateOldPasswordChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class PasswordUpdatePasswordChanged extends PasswordUpdateEvent {
  const PasswordUpdatePasswordChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class PasswordUpdateConfirmPasswordChanged extends PasswordUpdateEvent {
  const PasswordUpdateConfirmPasswordChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class PasswordUpdateSubmitted extends PasswordUpdateEvent {
  const PasswordUpdateSubmitted();
}
