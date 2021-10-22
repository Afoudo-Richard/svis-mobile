part of 'user_list_bloc.dart';

enum UserListStatus { initial, success, failure }

class UserListState extends Equatable {
  const UserListState({
    this.status = UserListStatus.initial,
    this.profileUserTypes = const <ProfileUserTypes>[],
    this.profileUsers = const <ProfileUser>[],
    this.hasReachedMax = false,
  });

  final UserListStatus status;
  final List<ProfileUserTypes> profileUserTypes;
  final List<ProfileUser> profileUsers;
  final bool hasReachedMax;

  UserListState copyWith({
    UserListStatus? status,
    List<ProfileUserTypes>? profileUserTypes,
    List<ProfileUser>? profileUsers,
    bool? hasReachedMax,
  }) {
    return UserListState(
      status: status ?? this.status,
      profileUserTypes: profileUserTypes ?? this.profileUserTypes,
      profileUsers: profileUsers ?? this.profileUsers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''UserListState { status: $status, hasReachedMax: $hasReachedMax, profileUserTypes: ${profileUserTypes.length}, profileUsers: ${profileUsers.length} } }''';
  }

  @override
  List<Object> get props => [
        status,
        profileUserTypes,
        profileUsers,
        hasReachedMax,
      ];
}
