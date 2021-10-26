part of 'groups_bloc.dart';

enum GroupsStatus { initial, success, failure }

class GroupsState extends Equatable {
  final bool hasReachedMax;
  final GroupsStatus status;
  final List<ProfileUserGroup> items;

  const GroupsState({
    this.status = GroupsStatus.initial,
    this.items = const <ProfileUserGroup>[],
    this.hasReachedMax = false,
  });

  GroupsState copyWith({
    GroupsStatus? status,
    List<ProfileUserGroup>? items,
    bool? hasReachedMax,
  }) {
    return GroupsState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        status,
        items,
        hasReachedMax,
      ];
}
