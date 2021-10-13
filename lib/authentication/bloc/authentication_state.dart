part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.passwordReset()
      : this._(status: AuthenticationStatus.passwordReset);

  const AuthenticationState.registration()
      : this._(status: AuthenticationStatus.registration);

  const AuthenticationState.welcome()
      : this._(status: AuthenticationStatus.welcome);

  final AuthenticationStatus status;
  final User? user;
  AuthenticationState.fromJson(Map<String, dynamic> json)
      : this._(
          // user: User.clone().fromJson(json['user']), todo fix
          status: AuthenticationStatus.values
              .firstWhere((e) => e.toString() == json['status']),
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status.toString();
    return data;
  }

  @override
  List<Object?> get props => [status, user];
}
