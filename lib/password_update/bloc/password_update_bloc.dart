import 'dart:io';

import 'package:app/commons/forms/forms.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

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
      try {
        /* ParseResponse response = await _authenticationRepository.resetPassword(
          username: state.oldPassword.value,
        );
        if (response.success) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            error: response.error?.message ?? 'unable to login',
          ));
        } */

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
