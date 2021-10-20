import 'dart:io';

import 'package:app/commons/forms/forms.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'password_update_event.dart';

part 'password_update_state.dart';

class PasswordUpdateBloc
    extends Bloc<PasswordUpdateEvent, PasswordUpdateState> {
  PasswordUpdateBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const PasswordUpdateState()) {
    on<PasswordUpdateOldPasswordChanged>(_onUsernameChanged);
    on<PasswordUpdatePasswordChanged>(_onPasswordChanged);
    on<PasswordUpdateConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<PasswordUpdateSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    PasswordUpdateOldPasswordChanged event,
    Emitter<PasswordUpdateState> emit,
  ) {
    final value = Name.dirty(event.username);
    emit(state.copyWith(
      oldPassword: value,
      status: Formz.validate([
        value,
        state.password,
        state.confirmPassword,
      ]),
    ));
  }

  void _onPasswordChanged(
    PasswordUpdatePasswordChanged event,
    Emitter<PasswordUpdateState> emit,
  ) {
    final password = StrongPassword.dirty(event.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.oldPassword,
        password,
        state.confirmPassword,
      ]),
    ));
  }

  void _onConfirmPasswordChanged(
    PasswordUpdateConfirmPasswordChanged event,
    Emitter<PasswordUpdateState> emit,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
      original: state.password,
      value: event.value,
    );
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      status: Formz.validate([
        state.oldPassword,
        state.password,
        confirmPassword,
      ]),
    ));
  }

  void _onSubmitted(
    PasswordUpdateSubmitted event,
    Emitter<PasswordUpdateState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      var user = await ParseUser.currentUser() as User;
      try {
        var response = await ParseUser(
                user.emailAddress, state.oldPassword.value, user.emailAddress)
            .login();
        if (response.success) {
          user.password = state.password.value;
          ParseResponse response = await user.save();
          if (response.success) {
            emit(state.copyWith(
              status: FormzStatus.submissionSuccess,
              oldPassword: Name.pure(),
              password: StrongPassword.pure(),
              confirmPassword: ConfirmPassword.pure(),
            ));
          } else {
            emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              error: response.error?.message ?? 'unable to login',
            ));
          }
        } else {
          throw response.error?.message ?? 'unable to login';
        }

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (error) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          error: (error is SocketException)
              ? 'errors.socketException'
              : error.toString(),
        ));
      }
    }
  }
}
