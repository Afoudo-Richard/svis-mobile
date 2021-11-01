part of 'assign_group_bloc.dart';

class AssignGroupsState extends Equatable
    with fz.FormzMixin<String, ParseObject> {
  final Items<ProfileUserGroup?> groups;
  final Items<ProfileUser?> users;

  final fz.FormzSubmission<String, ParseObject> _submission;

  AssignGroupsState({
    this.groups = const Items.pure(),
    this.users = const Items.pure(),
    fz.FormzSubmission<String, ParseObject> status =
        const fz.FormzSubmission.pure(),
  }) : _submission = status;

  AssignGroupsState copyWith({
    Items<ProfileUserGroup?>? groups,
    Items<ProfileUser?>? users,
    fz.FormzSubmission<String, ParseObject>? submission,
  }) {
    return AssignGroupsState(
      groups: groups ?? this.groups,
      users: users ?? this.users,
      status: submission ?? this._submission,
    );
  }

  @override
  List<Object> get props => [
        groups,
        users,
        _submission,
      ];

  @override
  List<fz.FormzInput> get inputs => [
        groups,
        users,
      ];

  @override
  fz.FormzSubmission<String, ParseObject> get submission => _submission;
}
