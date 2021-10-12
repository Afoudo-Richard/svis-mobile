import 'dart:io';

import 'package:app/commons/forms/forms.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const RegisterState()) {
    on<RegisterFirstNameChanged>(_onFirstNameChanged);
    on<RegisterLastNameChanged>(_onLastNameChanged);
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onFirstNameChanged(
    RegisterFirstNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final value = Name.dirty(event.value);
    emit(state.copyWith(
      firstName: value,
      status: Formz.validate([
        value,
        state.lastName,
        state.username,
        state.password,
        state.confirmPassword
      ]),
    ));
  }

  void _onLastNameChanged(
    RegisterLastNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final value = Name.dirty(event.value);
    emit(state.copyWith(
      lastName: value,
      status: Formz.validate([
        state.firstName,
        value,
        state.username,
        state.password,
        state.confirmPassword
      ]),
    ));
  }

  void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Email.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        username,
        state.password,
        state.confirmPassword
      ]),
    ));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = StrongPassword.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.username,
        password,
        state.confirmPassword
      ]),
    ));
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmPassword =
        ConfirmPassword.dirty(original: state.password, value: event.password);
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      status: Formz.validate([
        state.firstName,
        state.lastName,
        state.username,
        state.password,
        confirmPassword
      ]),
    ));
  }

  void _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.register(
          firstName: state.firstName.value,
          lastName: state.lastName.value,
          email: state.username.value,
          password: state.password.value,
          confirmPassword: state.confirmPassword.value,
        );
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
