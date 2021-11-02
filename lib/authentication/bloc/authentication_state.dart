part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.profileUsers,
    this.profile,
    this.user,
    this.profileUserTypes,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated({
    required User? user,
    required List<ProfileUser>? profileUsers,
    required ProfileUser? profile,
    required List<ProfileUserTypes>? profileUserTypes,
  }) : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
          profileUsers: profileUsers,
          profile: profile,
          profileUserTypes: profileUserTypes,
        );

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
  final ProfileUser? profile;
  final List<ProfileUser>? profileUsers;
  final List<ProfileUserTypes>? profileUserTypes;
  AuthenticationState.fromJson(Map<String, dynamic> json)
      : this._(
          user: User.clone().fromJson(json['user']),
          profile: ProfileUser.clone().fromJson(json['profile']),
          profileUsers: (json['profileUsers'] as List<dynamic>)
              .map((item) => ProfileUser.clone().fromJson(item) as ProfileUser)
              .toList(),
          profileUserTypes: (json['profileUserTypes'] as List<dynamic>)
              .map((item) =>
                  ProfileUserTypes.clone().fromJson(item) as ProfileUserTypes)
              .toList(),
          status: AuthenticationStatus.values
              .firstWhere((e) => e.toString() == json['status']),
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile'] = this.profile?.toJson(full: true);
    data['profileUsers'] =
        this.profileUsers?.map((item) => item.toJson(full: true)).toList();
    data['profileUserTypes'] =
        this.profileUserTypes?.map((item) => item.toJson(full: true)).toList();
    data['status'] = this.status.toString();
    data['user'] = this.user?.toJson(full: true);
    return data;
  }

  @override
  List<Object?> get props => [
        status,
        user,
        profileUsers,
        profile,
      ];
}
