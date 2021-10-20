part of 'terminate_account_bloc.dart';

abstract class TerminateAccountEvent extends Equatable {
  const TerminateAccountEvent();

  @override
  List<Object> get props => [];
}

class TerminateAccountUsernameChanged extends TerminateAccountEvent {
  const TerminateAccountUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}
class TerminateAccountPasswordChanged extends TerminateAccountEvent {
  const TerminateAccountPasswordChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class TerminateAccountSubmitted extends TerminateAccountEvent {
  const TerminateAccountSubmitted();
}
