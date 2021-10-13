part of 'password_reset_bloc.dart';

abstract class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object> get props => [];
}

class PasswordResetUsernameChanged extends PasswordResetEvent {
  const PasswordResetUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class PasswordResetSubmitted extends PasswordResetEvent {
  const PasswordResetSubmitted();
}
