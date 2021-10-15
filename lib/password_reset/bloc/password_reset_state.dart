part of 'password_reset_bloc.dart';

class PasswordResetState extends Equatable {
  const PasswordResetState({
    this.status = FormzStatus.pure,
    this.username = const Email.pure(),
    this.error = '',
  });

  final FormzStatus status;
  final Email username;
  final String error;

  PasswordResetState copyWith({
    FormzStatus? status,
    Email? username,
    String? error,
  }) {
    return PasswordResetState(
      status: status ?? this.status,
      username: username ?? this.username,
      error: error ?? '',
    );
  }

  @override
  List<Object> get props => [status, username, error];
}
