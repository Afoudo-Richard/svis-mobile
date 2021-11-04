part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationProfileChanged extends AuthenticationEvent {
  const AuthenticationProfileChanged(this.profile);

  final ProfileUser profile;

  @override
  List<Object> get props => [profile];
}

class ProfileAdded extends AuthenticationEvent {
  const ProfileAdded(this.profile);

  final ProfileUser profile;

  @override
  List<Object> get props => [profile];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
