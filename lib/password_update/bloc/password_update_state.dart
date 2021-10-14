part of 'password_update_bloc.dart';

class PasswordUpdateState extends Equatable {
  const PasswordUpdateState({
    this.status = FormzStatus.pure,
    this.oldPassword = const Name.pure(),
    this.password = const StrongPassword.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.error = '',
  });

  final FormzStatus status;
  final Name oldPassword;
  final StrongPassword password;
  final ConfirmPassword confirmPassword;
  final String error;

  PasswordUpdateState copyWith({
    FormzStatus? status,
    Name? oldPassword,
    StrongPassword? password,
    ConfirmPassword? confirmPassword,
    String? error,
  }) {
    return PasswordUpdateState(
      status: status ?? this.status,
      oldPassword: oldPassword ?? this.oldPassword,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      error: error ?? '',
    );
  }

  @override
  List<Object> get props => [
        status,
        oldPassword,
        password,
        confirmPassword,
        error,
      ];
}
