part of 'user_list_bloc.dart';

enum UserListStatus { initial, success, failure }

class UserListState extends Equatable {
  const UserListState({
    this.status = UserListStatus.initial,
    this.items = const <ProfileUserTypes>[],
    this.hasReachedMax = false,
  });

  final UserListStatus status;
  final List<ProfileUserTypes> items;
  final bool hasReachedMax;

  UserListState copyWith({
    UserListStatus? status,
    List<ProfileUserTypes>? items,
    bool? hasReachedMax,
  }) {
    return UserListState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''UserListState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length} } }''';
  }

  @override
  List<Object> get props => [status, items, hasReachedMax];
}
