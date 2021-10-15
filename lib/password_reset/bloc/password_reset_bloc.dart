import 'dart:io';

import 'package:app/commons/forms/forms.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'password_reset_event.dart';

part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const PasswordResetState()) {
    on<PasswordResetUsernameChanged>(_onUsernameChanged);
    on<PasswordResetSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    PasswordResetUsernameChanged event,
    Emitter<PasswordResetState> emit,
  ) {
    final username = Email.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username]),
    ));
  }

  void _onSubmitted(
    PasswordResetSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        ParseResponse response = await _authenticationRepository.resetPassword(
          username: state.username.value,
        );
        if (response.success) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            error: response.error?.message ?? 'unable to login',
          ));
        }
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
