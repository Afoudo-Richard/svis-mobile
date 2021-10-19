part of 'terminate_account_bloc.dart';

class TerminateAccountState extends Equatable {
  const TerminateAccountState({
    this.status = FormzStatus.pure,
    this.username = const CurrentEmail.pure(),
    this.password = const Name.pure(),
    this.error = '',
  });

  final FormzStatus status;
  final CurrentEmail username;
  final Name password;
  final String error;

  TerminateAccountState copyWith({
    FormzStatus? status,
    CurrentEmail? username,
    Name? password,
    String? error,
  }) {
    return TerminateAccountState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      error: error ?? '',
    );
  }

  @override
  List<Object> get props => [status, username, password, error];
}
