import 'dart:io';

import 'package:app/commons/forms/forms.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'terminate_account_event.dart';

part 'terminate_account_state.dart';

class TerminateAccountBloc
    extends Bloc<TerminateAccountEvent, TerminateAccountState> {
  TerminateAccountBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const TerminateAccountState()) {
    on<TerminateAccountUsernameChanged>(_onUsernameChanged);
    on<TerminateAccountPasswordChanged>(_onPasswordChanged);
    on<TerminateAccountSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    TerminateAccountUsernameChanged event,
    Emitter<TerminateAccountState> emit,
  ) async {
    var user = await ParseUser.currentUser();
    final username =
        CurrentEmail.dirty(original: user.emailAddress, value: event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.password]),
    ));
  }

  void _onPasswordChanged(
    TerminateAccountPasswordChanged event,
    Emitter<TerminateAccountState> emit,
  ) {
    final value = Name.dirty(event.value);
    emit(state.copyWith(
      password: value,
      status: Formz.validate([value, state.username]),
    ));
  }

  void _onSubmitted(
    TerminateAccountSubmitted event,
    Emitter<TerminateAccountState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        ParseResponse response = await ParseUser(state.username.value,
                state.password.value, state.username.value)
            .login();
        if (response.success) {
          var user = await ParseUser.currentUser();
          ParseResponse response = await user.destroy();
          if (response.success) {
            emit(state.copyWith(status: FormzStatus.submissionSuccess));
          } else {
            emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              error: response.error?.message ?? 'unable to terminate account',
            ));
          }
        } else {
          emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            error: response.error?.message ?? 'verify credentials',
          ));
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
